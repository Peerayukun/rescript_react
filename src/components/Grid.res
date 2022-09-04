@module external styles: {..} = "../styles.module.css"
let arr = Belt.Array.range(0,2)
let color = Belt.Array.map(Belt.Array.range(0,9),(_)=>{
    `rgb(${Belt.Int.toString(Js.Math.random_int(0,255))},
        ${Belt.Int.toString(Js.Math.random_int(0,255))},
        ${Belt.Int.toString(Js.Math.random_int(0,255))})`
})
let goal = ["012","345","678","036","147","258","048","246"]

@react.component
let make=(~setStatus)=>{
    let (turnx,setTurnx) = React.useState(_=>true)
    let (board,setBoard) = React.useState(_=>Belt.Array.make(9,""))
    let playerClick=(e,n)=>{
        ReactEvent.Mouse.preventDefault(e)
        setTurnx(prev=>!prev)
        let newBoard = Belt.Array.copy(board)
        let disableAll=()=>{
            Belt.Array.forEachWithIndex(newBoard,(index,item)=>{
                if(item===""){
                    Belt.Array.setExn(newBoard,index," ")
                }
            })
        }
        if(turnx){
            Belt.Array.setExn(newBoard,n,"x")
        }
        else{
            Belt.Array.setExn(newBoard,n,"o")
        }
        Belt.Array.forEachWithIndex(goal,(index,item)=>{
            if(Js.String.includes(Belt.Int.toString(n),item)){
                if(turnx){
                    Belt.Array.setExn(goal,index,
                        Js.String.replace(Belt.Int.toString(n),"x",item)
                    )
                }
                else{
                    Belt.Array.setExn(goal,index,
                        Js.String.replace(Belt.Int.toString(n),"o",item)
                    )
                }
            }
        })
        if(Belt.Array.some(goal,(item)=>item==="xxx")){
            setStatus(_=>"X win")
            disableAll()
        }
        else if(Belt.Array.some(goal,(item)=>item==="ooo")){
            setStatus(_=>"O win")
            disableAll()
        }
        else{
            if(turnx){
                setStatus(_=>"Turn O")
            }
            else{
                setStatus(_=>"Turn X")
            }
            if(Belt.Array.every(newBoard,(item)=>item!=="")){
                setStatus(_=>"Draw")
            }
        }
        setBoard(_=>newBoard)
    }
    <div>
        {React.array(Belt.Array.map(arr,(y)=>{
            <div>
                {React.array(Belt.Array.map(arr,(x)=>{
                    let idx = 3*y+x
                    <input 
                    className={styles["button"]}
                    style={ReactDOM.Style.make(~backgroundColor=Belt.Array.getExn(color,idx),())}
                    onClick={playerClick(_,idx)}
                    disabled={Belt.Array.getExn(board,idx)!==""}
                    readOnly={true}
                    value={Belt.Array.getExn(board,idx)}/>
                }))}
            </div>
        }))}
    </div>
}