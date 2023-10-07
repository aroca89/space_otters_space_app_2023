const fs = require('fs');
const {parse} = require('csv-parse');

const nombreArchivoCSV = process.argv[2];
const nombreArchivoJSON = process.argv[3];

result = [];

fs.createReadStream(nombreArchivoCSV)
  .pipe(parse({ delimiter: ',' }))
  .on('data', (row) => {
	result.push({
		date: row[0]+'-'+row[1]+'-'+row[2],
		field: row[3],
		flowSpeed: row[7],
		flowDensity: row[8]
	});
  }).on('end', () => {
	fs.writeFileSync(nombreArchivoJSON, JSON.stringify(result));
  });
