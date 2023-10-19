console.log("Hello My FrienD")

const arg = process.argv.slice(2);
const a = arg[0];
const b = String(arg[1]);
const c = `Ciao ${a} come stai ${b}` 
console.log(a);
console.log(b);
console.log(c);
