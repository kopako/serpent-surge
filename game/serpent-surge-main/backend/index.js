// Don't forget to specify the credentials at the 'db' constant part!

const express = require('express');
const mysql = require('mysql2');
const port = 3000;
const cors = require('cors');
const app = express();
const dbHost = process.env.DB_HOST;
const dbUser = process.env.DB_USER;
const dbPass = process.env.DB_PASSWORD;
const database = process.env.DB_NAME;

console.info(`DB CONFIGURATION:\n host:${dbHost}\n user:${dbUser}\n database: ${database}`);

app.use(cors());

// Database credentials - make sure you don't store sensitive information here in plain text!
const db = mysql.createConnection({
    host: dbHost,
    user: dbUser,
    password: dbPass,
    database: database,
    port: '3306'
});


db.connect((err) => {
    if (err) {
        console.error('Error connecting to MySQL:', err.message);
        process.exit(1);
    }
    console.log('Connected to MySQL');
    
    const createTableQuery = `
        CREATE TABLE IF NOT EXISTS scores (
            id INT AUTO_INCREMENT PRIMARY KEY,
            name VARCHAR(255) NOT NULL,
            difficulty INT NOT NULL,
            score INT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    `;

    db.query(createTableQuery, (err) => {
        if (err) {
            console.error('Error creating scores table:', err.message);
            process.exit(1);
        }
        console.log('Scores table is ready.');
    });
});
    

app.use(express.json());

// Endpoint for saving scores with a POST request
app.post('/save-score', (req, res) => {
    const { name, difficulty, score } = req.body;

    if (name.length !== 3 || difficulty < 1 || difficulty > 3) {
        return res.status(400).json({ message: "Invalid input" });
    }

    const calculatedScore = difficulty * score;

    db.query(`INSERT INTO scores (name, difficulty, score) VALUES (?, ?, ?)`,
        [name, difficulty, calculatedScore],
        (err) => {
            if (err) {
                return res.status(500).json({ message: "Error saving score" });
            }
            res.status(200).json({ message: "Score saved successfully!" });
        });
});

// Endpoint for getting the top 10 scores from the DB with a GET request
app.get('/top-scores', (req, res) => {
    db.query(`SELECT name, difficulty, score FROM scores ORDER BY score DESC LIMIT 10`, (err, results) => {
        if (err) {
            return res.status(500).json({ message: "Error retrieving scores" });
        }
        res.status(200).json(results);
    });
});

app.listen(port,'0.0.0.0', () => {
    console.log(`Server running on http://localhost:${port}`);
});
