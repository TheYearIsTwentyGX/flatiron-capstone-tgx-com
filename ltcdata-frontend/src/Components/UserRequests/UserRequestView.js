import Button from "../CommonUI/Button";
import Card from "../CommonUI/Card";
import "./UserRequestView.css"

export default function UserRequestView({ request }) {

    let regBuildings = [];
    if (request.Buildings !== undefined) {
        regBuildings = request.Buildings.split(/[;\n]/);
        if (regBuildings.length < 1)
            regBuildings.push(request.Buildings)
    }

    return (
        <Card title="Current Request">
            <div className="user-view">
                <div className="second-card">
                    <h3 className="thin-header">First Name:</h3>
                    <input type="text" className="login-textblock" value={request.FirstName} />
                    <h3 className="thin-header">Last Name:</h3>
                    <input type="text" className="login-textblock" value={request.LastName} />
                </div>
                <div className="second-card">
                    <h3 className="thin-header">Credentials:</h3>
                    <input type="text" className="login-textblock" value={request.Credentials} />
                    <h3 className="thin-header">Position:</h3>
                    <input type="text" className="login-textblock" value={request.User_Position} />
                </div>
                <div className="second-card">
                    <h3 className="thin-header">Request Type:</h3>
                    <input className="login-textblock" type="text" value={request.Request_Type} />
                    <h3 className="thin-header">Requested By:</h3>
                    <h4 className="thin-header">{request.Requester}</h4>
                </div>
                <div className="second-card">
                    <h3 className="thin-header">Date Requested:</h3>
                    <h4 className="thin-header">{new Date(request.Request_When).toLocaleString()}</h4>
                    <h3 className="thin-header">Effective Date:</h3>
                    <input className="login-textblock" type="date" value={request.Effective_Date.split('T')[0]} />
                </div>
                <div className="second-card">
                    <h3 className="thin-header">Requested Access:</h3>
                    <ul>
                        {request.Access_LTC ? <li className="access-text">LTC</li> : null}
                        {request.Access_PCC ? <li className="access-text">PCC</li> : null}
                        {request.Access_POC ? <li className="access-text">POC</li> : null}
                        {request.Access_Riskwatch ? <li className="access-text">Riskwatch</li> : null}
                        {request.Access_POC ? <li className="access-text">Carewatch</li> : null}
                    </ul>
                </div>
                <div className="second-card">
                    <h3 className="thin-header">Requested Facilities:</h3>
                    {regBuildings.length > 1 ?
                        <ul>
                            {regBuildings.map((building) => (
                                <li className="access-text">{building}</li>))}
                        </ul> : <h4 className="thin-header">{regBuildings[0].length < 1 ? "None requested" : regBuildings[0]}</h4>}
                </div>
                {request.Notes.length > 0 ? (<div className="second-card"><h3 className="thin-header">Special Notes:</h3><textarea className="login-textblock" value={request.Notes} /></div>) : null}
            </div>
            <div className="maxed">
                <h3 className="thin-header">Status Notes:</h3>
                <textarea className="login-textblock" value={request.StatusNotes} />
            </div>

            <div className="general-flex">
                <Button text={"Update Request"} clickEvent={null} dark={true} />
                <Button text={"Complete Request"} clickEvent={null} dark={true} />
            </div>
        </Card>
    )

}