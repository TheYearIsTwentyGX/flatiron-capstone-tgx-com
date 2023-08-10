import React, { useEffect, useState, useContext } from 'react';
import './NewUserRequestForm.css';
import { UserContext } from '../../Context/UserContext';
import { useHistory } from 'react-router-dom';

export default function NewUserRequestForm() {
    const [values, setValues] = useState({});
    const { username, user, accessProfiles, setAccessProfiles } = useContext(UserContext);
    const [possibleFacilities, setPossibleFacilities] = useState([]);
    const [selectedFacilities, setSelectedFacilities] = useState([]);
    const [addedFacilities, setAddedFacilities] = useState([]);
    const history = useHistory();
    useEffect(() => {
        if (username === "") {
            history.push('/');
        }

        fetch('http://10.1.1.40:3000/users/' + username + '/facilities/census')
            .then(response => response.json())
            .then(data => setPossibleFacilities(data.Facilities));

        if (accessProfiles == null) {
            fetch('http://10.1.1.40:3000/user_request_positions')
                .then(response => response.json())
                .then(data => setAccessProfiles(data));
        }
    }, []);

    function updateSelection(e) {
        setSelectedFacilities([possibleFacilities.find(facility => facility.Report_Name === e.target.value)]);
    }

    function updateAdded(e) {
        for (let fac of selectedFacilities) {
            possibleFacilities.splice(possibleFacilities.indexOf(fac), 1);
        }
        setAddedFacilities([...addedFacilities, ...selectedFacilities]);
    }

    return (
        <div className='variableSizedCard'>
            <h1>New User Request</h1>
            <form>
                <div className='new-user-form'>
                    <div>
                        <div>
                            <label for='first_name'>First Name</label>
                            <input className='login-textblock' name='first_name' id='first_name' type='text' />
                        </div>
                        <div>
                            <label for='last_name'>Last Name</label>
                            <input className='login-textblock' name='last_name' id='last_name' type='text' />
                        </div>
                    </div>
                    <div className='standard-flex'>
                        <div>
                            <label for='credentials'>Credentials</label>
                            <input className='login-textblock' name='credentials' id='credentials' type='text' />
                        </div>
                        <div>
                            <label for='position'>Position</label>
                            <select className='select-dark'>
                                {accessProfiles === null || accessProfiles.length === 0 ? null : accessProfiles?.map((accessProfile) => (<option value={accessProfile.ID}>{accessProfile.id}</option>))}
                            </select>
                        </div>
                    </div>
                    <div className='standard-flex'>
                        <div>
                            <label for='facilities'>Facilities</label>
                            <select multiple className='multi-select' onChange={updateSelection}>
                                {possibleFacilities === null ? null : possibleFacilities?.map((facility) => (<option value={facility.Report_Name}>{facility.Report_Name}</option>))}
                            </select>
                        </div>
                        <div className='arrow-container'>
                            <div>
                                <img className='arrow' onClick={updateAdded}
                                    src='https://th.bing.com/th/id/R.0673093bbfcecc10fc43a2e61243415c?rik=qmA2sEFmCjuKWQ&riu=http%3a%2f%2fclipart-library.com%2fimages_k%2ftransparent-arrow-image%2ftransparent-arrow-image-3.png&ehk=q1%2b6xULlNSs6PGgvTMuuC9MdpzUXg186xJS2kWhEoj8%3d&risl=&pid=ImgRaw&r=0' />
                            </div>
                            <img className='arrow'
                                src='https://th.bing.com/th/id/R.469b8ed154033e2bd69fc32507d1bc1b?rik=fgNpW5GOCXlCPw&riu=http%3a%2f%2fwww.pngmart.com%2ffiles%2f3%2fLeft-Arrow-PNG-File.png&ehk=xk1z4feqGS7kKiw6PDjCXMZ8isZAm0orp0PtMSKa2EM%3d&risl=&pid=ImgRaw&r=0' />
                        </div>
                        <div>
                            <label for='added_facilities'>Added Facilities</label>
                            <select multiple className='multi-select'>
                                {addedFacilities?.map((facility) => (<option value={facility.Report_Name}>{facility.Report_Name}</option>))}
                            </select>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    )
}