category([
	pattern([can,you,show,me,a,picture,of,nature,'?']),
	template([please,go,to,'r/earthporn' ,'r/Natureporn',or,'r/Naturegifs','.'])
]).

category([
	pattern([is,reddit,better,than,star(A),'?']),
	template(['Yes',reddit,is,better,than,A,'.'])
]).

category([
	pattern(['How',old,is,reddit,'?']),
	template(['Reddit',has,been,founded,on,23,'June',2005,so,it,is,around,11,years,old,'.'])
]).

category([
	pattern(['What',is,reddit,'?']),
	template(['Reddit',is,a,social,news,website,on,which,users,can,post,posts,and,users,can,upvote,posts,or,subscribe,to,subreddits,'.'])
]).

category([
	pattern(['Where',can,i,find,funny,memes,'?']),
	template(['Please',go,'to:','r/trebuchetmemes','or','r/meirl','.'])
]).

category([
	pattern(['Where',can,i,find,star(A),'?']),
	template(['Please',go ,'to:','r/',A,'.',think([Head|_] = A), think(string_concat('sensible-browser www.reddit.com/r/', Head, B)), think(shell(B))])
]).