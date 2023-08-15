import Card from "../CommonUI/Card";

function EmployeeView({ employee }) {

    return (
        <div className="card-root">
            <h2>{employee.Title.length < 1 ? "Unknown" : employee.Title}</h2>
            <h3>{employee.Full_Name}</h3>
        </div>)
}

export default EmployeeView;