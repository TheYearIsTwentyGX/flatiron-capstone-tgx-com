import { useState } from 'react';
import { useHistory } from 'react-router';
import './ExpandingButton.css'

export default function ExpandingButton({ text, children = [], primary_location = null }) {
    const [expanded, setExpanded] = useState(true);
    const [childClasses, setChildClasses] = useState("nested");
    const history = useHistory();

    const hoverable = children.length > 0 ? "dropdown-content" : "no-dropdown-content";
    //const hoverable =  "dropdown-content";

    function toggleExpand() {
        if (primary_location != null) {
            history.push(primary_location);
        }

        setExpanded(!expanded);
        if (expanded) {
            setChildClasses(["active"]);
        }
        else {
            setChildClasses(["nested"]);
        }
    }

    function buttonClick(e) {
        const child = children.find(x => x.Name === e.target.innerText);
        history.push(child.Location);
    }

    return (
    <div className='dropdown'>
        <button className='dropbtn'>{text}</button>
        <div className={hoverable}>
            <ul >

            {children.map(x => {
                return (<li onClick={buttonClick} className={`sub-button ${childClasses}`}>{x.Name}</li>);
                })}
                </ul>
        </div>
    </div>)
}