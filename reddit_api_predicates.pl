%% Get karma
user_karma(User, Link, Comment) :-
	user_info(User, Info),
	member(link_karma=Link, Info),
	member(comment_karma=Comment, Info),!.

user_info(User, Info) :-
	format(atom(Url), 'https://www.reddit.com/user/~s/about.json', User),
	http_open(Url, S, []),
	json_read(S, json(K), []),
	member(data=Cre, K),
	arg(1, Cre, Info),!.

top_post_info(Subreddit, Url, Title) :-
	format(atom(Url), 'https://www.reddit.com/r/~s/top.json?limit=1&t=all', Subreddit),
	http_open(Url, Stream, []),
	json_read(Stream, json(List), []),
	member(data=Data, List),
	arg(1, Data, Info),
	member(children=Children, Info),
	arg(1, Children, T2),
	arg(1, T2, T3),
	member(data=T4, T3),
	arg(1, T4, T5),
	member(url=T6, T5),
	member(title=Title, T5),
	remove_from_atom(T6, 'amp;', Url),!.

get_random_sub(Url) :-
	http_open('https://www.reddit.com/r/random.json', Stream, []),
	json_read(Stream, json(List), []),
	member(data=Data, List),
	arg(1, Data, Info),
	member(children=Children, Info),
	arg(1, Children, T0),
	member(data=Url, T0).
