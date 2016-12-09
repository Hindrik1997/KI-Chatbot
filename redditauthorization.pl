:- discontiguous category/1.

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
	template(["I've",opened,up,a,window,for,you,to,log,in,to,'.','When',you,get,back,you,should,be,logged,in,think(open("https://www.reddit.com/api/v1/authorize?client_id=8MKVSb9CStTzqg&response_type=code&state=staatuuss&redirect_uri=http://www.ruurdbijlsma.com/prolog&duration=permanent&scope=identity edit flair history modconfig modflair modlog modposts modwiki mysubreddits privatemessages read report save submit subscribe vote wikiedit wikiread", Html)), Html])
]).