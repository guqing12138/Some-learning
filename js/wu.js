var str = 'window';  
 
const obj = {
    str:'obj',
    fn: ()=>{
	console.log(this.str);	
    }
}
 
obj.fn();