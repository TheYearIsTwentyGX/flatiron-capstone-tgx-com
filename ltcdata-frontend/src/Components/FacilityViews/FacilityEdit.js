import Card from "../CommonUI/Card";
import "./FacilityEdit.css";
import { useState, useContext } from "react";
import { useHistory, useParams } from "react-router-dom";
import { UserContext } from "../../Context/UserContext";

export default function FacilityEdit() {
  const { userFacilities, setUserFacilities } = useContext(UserContext);

  const [formValues, setFormValues] = useState({});
  const [selectedFacility, setSelectedFacility] = useState("");
  const [errors, setErrors] = useState([]);
  const { id = "" } = useParams();
  const history = useHistory();

  function onInputChange(e) {
    console.log(errors);
    setFormValues({ ...formValues, [e.target.name]: e.target.value });
  }

  function editedFacilityChanged(e) {
    if (e.target.value === "") {
      setSelectedFacility("");
      return;
    }
    history.push("/admin/edit_facility/" + e.target.value)
    setSelectedFacility(e.target.value);
    setFormValues(userFacilities.find(f => f.Coserial == e.target.value));
  }

  function addingNew() {
    setSelectedFacility("");
    setErrors([]);
    setFormValues({ Coserial: "", Report_Name: "", Phone: "", Fax: "", Address1: "", Address2: "", City: "", State: "", Zip: "" });
  }

  function facilityFormSubmitted() {
    const postOrPatch = selectedFacility == "" ? ['', 'POST'] : [id, 'PATCH'];

    const body = formValues;
    body.OldCoserial = id;

    fetch('http://localhost:3002/facilities/' + postOrPatch[0], {
      method: postOrPatch[1],
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(body)
    }).then(response => response.json())
      .then(data => {
        if (data.errors) {
          setErrors(data.errors);
          return;
        }
        if (selectedFacility == "") {
          addingNew();
          setUserFacilities([...userFacilities, data]);
        }
        else {
          let oldFac = userFacilities.filter(f => f.Coserial != id);
          setUserFacilities([...oldFac, data]);
        }
        history.push("/admin/edit_facility/" + data.Coserial)
      })
  }

  return (
    <div className="facilityEditor">

      <Card title="Edit Facility">
        <label for='selected-facility'>Facility to Edit</label>
        <select id="facility-selector" name='selected-facility' className='select-dark' value={selectedFacility} onChange={editedFacilityChanged}>
          <option value={null} />
          {userFacilities?.map((facility) => (<option value={facility.Coserial}>{facility.Report_Name}</option>))}
        </select>
        <div className="submit-button" onClick={addingNew}>
          Add a New Facility
        </div>
        <div className="facility-card">
          <div>
            <label htmlFor="Coserial">Company Number:</label>
            <input onChange={onInputChange} type="text" value={formValues.Coserial} className="form-textblock" name="Coserial" />
            <label htmlFor="Report_Name">Company Name:</label>
            <input onChange={onInputChange} type="text" value={formValues.Report_Name} className="form-textblock" name="Report_Name" />
          </div>
          <div>
            <label htmlFor="Phone">Phone Number:</label>
            <input onChange={onInputChange} type="text" value={formValues.Phone} className="form-textblock" name="Phone" />
            <label htmlFor="Fax">Fax Number:</label>
            <input onChange={onInputChange} type="text" value={formValues.Fax} className="form-textblock" name="Fax" />
          </div>
          <div>
          </div>
          <div>
            <label htmlFor="Address1">Address 1:</label>
            <input onChange={onInputChange} type="text" value={formValues.Address1} className="form-textblock" name="Address1" />
            <label htmlFor="Address2">Address 2:</label>
            <input onChange={onInputChange} type="text" value={formValues.Address2} className="form-textblock" name="Address2" />
            <label htmlFor="City">City:</label>
            <input onChange={onInputChange} type="text" value={formValues.City} className="form-textblock" name="City" />
            <label htmlFor="State">State:</label>
            <input onChange={onInputChange} type="text" value={formValues.State} className="form-textblock" name="State" />
            <label htmlFor="Zip">Zip:</label>
            <input onChange={onInputChange} type="text" value={formValues.Zip} className="form-textblock" name="Zip" />
          </div>
        </div>
        <div className="submit-button" onClick={facilityFormSubmitted}>
          Submit Facility
        </div>
        {errors.length > 0 ? (<div className="error-card">
          {errors.map(error => (<div className='error'>{error}</div>))}
        </div>) : null}
      </Card>
    </div>)
}