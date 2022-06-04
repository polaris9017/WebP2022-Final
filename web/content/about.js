function List(prop) {
    return <li className="list-group-item">
        <div className="me-2 me-auto">{prop.name}</div>
        <a href={prop.url} className="text-decoration-none text-muted">
            {prop.url}
        </a>
    </li>;
}

function App() {
    return (
        <ul className="list-group align-content-between">
            <List name="Bootstrap (Including Navbar example template)" url="https://getbootstrap.com"/>
            <List name="JQuery" url="https://jquery.com"/>
            <List name="React" url="https://reactjs.org"/>
            <List name="BabelJS (React JSX Interpreter)" url="https://babeljs.io"/>
            <List name="Server error page template" url="https://www.bootdey.com/snippets/view/500-internal-server-error-page"/>
        </ul>
    );
}

ReactDOM.render(<App/>, document.getElementById('list_body'));
