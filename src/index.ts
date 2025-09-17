import express from "express";
import connectToDatabase from "./db/connect";

const app = express();

app.use(express.json());

app.get("/", (_req, res) => {
	res.send("<h1>Welcome to Docker!</h1>");
});

await connectToDatabase();

app.listen(3000, () => {
	console.log("Server is running on port 3000");
});
