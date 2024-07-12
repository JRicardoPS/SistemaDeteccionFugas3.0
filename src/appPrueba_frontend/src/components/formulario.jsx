import { useState } from 'react';
import { appPrueba_backend } from 'declarations/appPrueba_backend';
import './app.scss';

function App() {
  const [formData, setFormData] = useState({
    cantidadAgua: '',
    ubicacion: '',
    estadoReparacion: 'Sin reparar',
  });

  const [message, setMessage] = useState('');

  function handleChange(event) {
    const { name, value } = event.target;
    setFormData({
      ...formData,
      [name]: value,
    });
  }

  async function handleSubmit(event) {
    event.preventDefault();
    const { cantidadAgua, ubicacion, estadoReparacion } = formData;
    try {
      await appPrueba_backend.agregarFuga(parseInt(cantidadAgua), ubicacion, estadoReparacion);
      setMessage('Datos guardados con éxito');
    } catch (error) {
      console.error('Error al guardar los datos:', error);
      setMessage('Error al guardar los datos');
    }
  }

  return (
    <main>
      <img src="/logo2.svg" alt="DFINITY logo" />
      <br />
      <br />
      <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor="cantidadAgua">Cantidad de Agua Perdida (litros):</label>
          <input
            type="number"
            id="cantidadAgua"
            name="cantidadAgua"
            value={formData.cantidadAgua}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label htmlFor="ubicacion">Ubicación de la Fuga:</label>
          <input
            type="text"
            id="ubicacion"
            name="ubicacion"
            value={formData.ubicacion}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label htmlFor="estadoReparacion">Estado de la Reparación:</label>
          <select
            id="estadoReparacion"
            name="estadoReparacion"
            value={formData.estadoReparacion}
            onChange={handleChange}
            required
          >
            <option value="Sin reparar">Sin reparar</option>
            <option value="En reparación">En reparación</option>
            <option value="Reparada">Reparada</option>
          </select>
        </div>
        <button type="submit">Guardar</button>
      </form>
      <section id="message">{message}</section>
    </main>
  );
}

export default App;