const plotly = require('plotly.js-node');
const fs = require('fs');

// Lee el archivo CSV (cambia 'tu-archivo.csv' por el nombre de tu archivo)
const csvData = fs.readFileSync('tu-archivo.csv', 'utf8');

// Parsea el CSV en un array de objetos
const parseCSV = csv => {
  const rows = csv.trim().split('\n');
  const headers = rows[0].split(',');
  return rows.slice(1).map(row => {
    const values = row.split(',');
    return headers.reduce((obj, header, index) => {
      obj[header] = values[index];
      return obj;
    }, {});
  });
};

// Convierte los datos CSV en un formato aceptado por Plotly
const convertToPlotlyFormat = data => {
  const keys = Object.keys(data[0]);
  const values = keys.map(key => data.map(obj => obj[key]));

  return keys.map((key, index) => ({
    type: 'scatter',
    mode: 'lines+markers',
    name: key,
    x: data.map(obj => obj[keys[0]]),
    y: values[index],
  }));
};

// Crea un gráfico y guarda el archivo HTML con el gráfico
const createPlot = async data => {
  const plotData = convertToPlotlyFormat(data);

  const graphOptions = { fileopt: 'overwrite', filename: 'csv-plot' };

  const figure = {
    data: plotData,
    layout: { title: 'Gráfico de Datos CSV' },
  };

  plotly.plot(figure, graphOptions, function (err, msg) {
    if (err) return console.error(err);
    
    console.log(msg);
  });
};

// Ejecuta todo
const main = () => {
  const parsedData = parseCSV(csvData);
  createPlot(parsedData);
};

main();
