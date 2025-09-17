const connectToDatabase = async () => {
	return new Promise((resolve) => {
		setTimeout(() => {
			resolve("Connected to database");
		}, 1000);
	});
};

export default connectToDatabase;
