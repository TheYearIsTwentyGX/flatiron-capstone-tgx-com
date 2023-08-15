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
		fetch("http://localhost:3000/users")
			.then(response => response.json())
			.then(response => { console.log(response); return response; })
			.then(data => setUserRequests(data));
	}, []);

	function newRequest() {
		history.push("/admin/user_requests/new");
	}

	function goToUserRequest(e) {
		const txt = e.target.parentNode.querySelector("td:nth-of-type(5)").innerText;
		const req = userRequests.find(x => x.id == txt);
		setCurrentRequest(req);
		history.push(`/admin/user_requests/${txt}`)
	}
	return (<div className="page-root">
		<div className="page-content">
			<Card title="User Requests">
				<div onClick={newRequest} className="button">
					Add a New User
				</div>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Date Added</th>
							<th>Position</th>
							<th>Facilities</th>
							<th className="extra-space">User ID</th>
						</tr>
					</thead>
					<tbody>
						{userRequests?.map((userRequest) => (
							<tr className="user-row" key={userRequest.id} onClick={goToUserRequest}>
								<td>{userRequest.Full_Name}</td>
								<td>{new Date(userRequest.created_at).toLocaleDateString()}</td>
								<td>{userRequest.Access_Profile}</td>
								<td>{userRequest.Facilities.map(x => (<div key={x} >{x}</div>))}</td>
								<td >{userRequest.id}</td>
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