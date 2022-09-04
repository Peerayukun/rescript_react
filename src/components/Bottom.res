@module external styles: {..} = "../styles.module.css"
@react.component
let make=(~status)=>{
    <div>
        <p style={ReactDOM.Style.make(~textAlign="center",())}>{"Just a 2 players tic tac toe game"->React.string}</p>
        <h1 style={ReactDOM.Style.make(~textAlign="center",())}>{status->React.string}</h1>
        <button onClick={_=>{%raw("window.location.reload()")}} className={styles["restart"]}>{"restart"->React.string}</button>
    </div>
}