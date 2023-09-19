import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import './ExpandingButton.css'

export default function ExpandingButton({ text, children = [], primary_location = null }) {
	const [expanded, setExpanded] = useState(true);
	const [childClasses, setChildClasses] = useState("nested");
	const navigate = useNavigate();

	const hoverable = children.length > 0 ? "dropdown-content" : "no-dropdown-content";
	//const hoverable =  "dropdown-content";

	function toggleExpand() {
		if (primary_location != null) {
			navigate(primary_location);
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
		navigate(child.Location);
	}

	return (
		<div className='dropdown'>
			<button className='dropbtn'>{text}</button>
			<div className={hoverable}>
				<ul >

					{children.map(x => {
						return (<li onClick={buttonClick} key={x.Name} className={`sub-button ${childClasses}`}>{x.Name}</li>);
					})}
				</ul>
			</div>
		</div>)
}