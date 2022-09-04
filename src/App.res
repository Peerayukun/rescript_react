@module external styles: {..} = "./styles.module.css"

@react.component
let make =()=>{
  let (status,setStatus) = React.useState(_=>"Turn X")
  <div className={styles["App"]}>
    <Title/>
    <Grid setStatus=setStatus/>
    <Bottom status=status/>
  </div>
}
//npm run re:start
