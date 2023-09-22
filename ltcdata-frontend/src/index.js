import React from 'react';
import ReactDOM from 'react-dom';
import { createRoot } from 'react-dom';
import './index.css';
import App from './App';
import { BrowserRouter } from 'react-router-dom';
import reportWebVitals from './reportWebVitals';
import { UserProvider } from './Context/UserContext';
import { UserFormProvider } from './Context/UserFormContext';

const rootElement = document.getElementById('root')
const root = createRoot(rootElement);
root.render(
  <BrowserRouter>
    <UserProvider>
      <UserFormProvider>
        <App />
      </UserFormProvider>
    </UserProvider>
  </BrowserRouter>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
