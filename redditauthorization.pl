category([
	pattern(['Do you think you are',star(A),'?']),
	template(['I am a chatbot, ofcourse i am',A,'!?'])
]).

category([
	pattern([yes]),
	that(['Thanks',for,the,code,'!','It',was,star(_),'right?']),
	template(['Great!,',you,are,now,logged,in,as])
]).
category([
	pattern([no]),
	that(['Thanks',for,the,code,'!','It',was,star(_),'right?']),
	template(['Please',try,pasting,the,code,again])
]).

category([
	pattern([the,code,is,star(A)]),
	template([srai([A])])
]).

category([
	pattern([star(Code)]),
	that(['You',can,log,in,on,this,page,',',when,you,come,back,please,tell,me,the,code]),
	template(['Thanks',for,the,'code!','It',was,Code,'right?'])
]).
category([
	pattern([star(Code)]),
	that(['Please',try,pasting,the,code,again]),
	template(['Thanks',for,the,'code!','It',was,Code,'right?'])
]).

category([
	pattern([star(_),log,star(_),in,star(_)]),
	template([srai([login])])
]).

category([
	pattern([star(_),'login',star(_)]),
	template(['You',can,log,in,on,this,'page,',when,you,come,back,please,tell,me,your,code,think(authorize)])
]).