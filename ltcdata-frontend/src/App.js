import { useState } from 'react';
import { useHistory } from 'react-router';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import logo from './logo.svg';
import './App.css';
import Login from './Components/Login';
import ViewFacilityInfo from './Components/FacilityViews/ViewFacilityInfo';
import Sidebar from './Components/Sidebar';
import UserRequestList from './Components/UserRequests/UserRequestList';
import MainContent from './Components/MainContent';
import { UserContext, UserProvider } from './Context/UserContext';
import './Common.css'
import ExpandingButton from './Components/ExpandingButton';



function App() {
  const history = useHistory();

  function onLogout() {
    history.push('/')
  }

  const SiteAdmin = [
    { Name: "User Management", Location: "/admin/user_requests" },
    { Name: "Facility Management", Location: "/admin/edit_facility" },
  ]

  const CorporateInfo = [
    { Name: "Corporate Schedule", Location: "/home" },
    { Name: "Corporate Time Records", Location: "/home" },
    { Name: "Field Staff Directory", Location: "/home" },
    { Name: "Corporate Staff Directory", Location: "/home" },
    { Name: "Facility Directory", Location: "/home" },
  ];

  return (
    <div className="App">
      <UserProvider>
        <div className='primary-layout'>
          <Switch>
            <Route exact path="/">
              <Login />
            </Route>
            <Route>
              <div className='new-header'>
                <div className='standard-flex header-content'>
                  <img src="http://10.1.1.37/favicon.ico" alt='LTCData Logo' />
                  <h1 className='centered-text'>LTCData Processing</h1>
                  <nav className='general-flex right-align'>
                    <ExpandingButton text="Site Admin" children={SiteAdmin} />
                    <ExpandingButton text="Corporate" children={CorporateInfo} />
                    <div onClick={onLogout}>
                      <ExpandingButton text="Logout" primary_location={'/'} />
                    </div>
                  </nav>
                </div>
              </div>
              <div className='main-content'>
                <MainContent />
              </div>
            </Route>
          </Switch>
        </div>
      </UserProvider>
    </div>
  );
}

export default App;
