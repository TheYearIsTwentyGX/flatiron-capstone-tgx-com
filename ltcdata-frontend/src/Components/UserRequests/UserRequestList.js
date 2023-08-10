import React, { useState, useEffect } from "react";
import { Switch, Route, useLocation } from "react-router-dom";
import { useHistory } from "react-router";
import "./UserRequestList.css"
import UserRequestView from "./UserRequestView";
import NewUserRequestForm from "./NewUserRequestForm";
import Card from "../CommonUI/Card";

function UserRequestList() {
    const [userRequests, setUserRequests] = useState([]);
    const [currentRequest, setCurrentRequest] = useState(null);
    const history = useHistory();
    const location = useLocation();
    useEffect(() => {
        fetch("http://10.1.1.40:3000/user_requests")
            .then(response => response.json())
            .then(data => setUserRequests(data));
    }, []);

    function newRequest() {
        history.push("/admin/user_requests/new");
    }

    function goToUserRequest(e) {
        const txt = e.target.parentNode.querySelector("td:nth-of-type(5)").innerText;
        const req = userRequests.find(x => x.ID == txt);
        setCurrentRequest(req);
        history.push(`/admin/user_requests/${txt}`)
    }
    return (<div className="page-root">
        <div className="page-content">
            <Card title="User Requests">
                <div onClick={newRequest} className="button">
                    Submit a new User Request
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Request Type</th>
                            <th>Status</th>
                            <th>Effective Date</th>
                            <th className="extra-space">Request ID</th>
                        </tr>
                    </thead>
                    <tbody>
                        {userRequests?.map((userRequest) => (
                            <tr className="user-row" key={userRequest.ID} onClick={goToUserRequest}>
                                <td>{`${userRequest.FirstName} ${userRequest.LastName}`}</td>
                                <td>{userRequest.Request_Type}</td><td>{userRequest.Done_By == null ? "Approved" : "In Progress"}</td>
                                <td>{new Date(userRequest.Effective_Date).toLocaleDateString()}</td>
                                <td >{userRequest.ID}</td>
                            </tr>))}
                    </tbody>
                </table>
            </Card>

            <Switch>
                <Route path="/admin/user_requests/new">
                    <NewUserRequestForm />
                </Route>
                <Route path="/admin/user_requests/:id">
                    <div className="form-section">
                        <UserRequestView request={currentRequest} />
                    </div>
                </Route>
            </Switch>
        </div>
    </div>)
}

export default UserRequestList;