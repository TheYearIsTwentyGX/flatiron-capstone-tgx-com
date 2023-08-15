import './Button.css';

export default function Button({ clickEvent, text, dark = false }) {
    return (
        <input type="button" className="standard-button" onClick={clickEvent} value={text} style={{ background: (dark ? "#67999a" : "#9acccd") }} />
    )
}