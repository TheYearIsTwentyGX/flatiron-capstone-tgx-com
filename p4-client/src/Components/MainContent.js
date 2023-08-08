import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import Login from './Login';
//import ViewFacilityInfo from './FacilityViews/ViewFacilityInfo';
//import Sidebar from './Sidebar';
//import UserRequestList from './UserRequests/UserRequestList';
import { UserContext } from '../Context/UserContext';
import { useContext } from 'react';

function MainContent() {
  const { username, setUsername } = useContext(UserContext);
  return (
    <div className='proot'>
    <Switch>
        <Route exact path="/">
          <Login username={username} setUsername={setUsername} />
        </Route>
        {/* <Route path="/home">
          <ViewFacilityInfo username={username} />
        </Route>
        <Route path="/admin/user_requests">
          <UserRequestList />
        </Route> */}
      </Switch>
    </div>
  )
}

export default MainContent;