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

random_post_info(Subreddit, Url, Title) :-
	format(atom(HREF), 'https://www.reddit.com/r/~s/random.json?limit=1&t=all', Subreddit),
	http_open(HREF, Stream, []),
	json_read_dict(Stream, D, []),
	arg(1,D,O),
	arg(1,O.data.children,Out),
	fix_reddit_url(Out.data.url, Url),
	Title=Out.data.title,!.

top_post_info(Subreddit, Url, Title) :-
	format(atom(HREF), 'https://www.reddit.com/r/~s/top.json?limit=1&t=all', Subreddit),
	http_open(HREF, Stream, []),
	json_read(Stream, json(List), []),
	member(data=Data, List),
	arg(1, Data, Info),
	member(children=Children, Info),
	arg(1, Children, T2),
	arg(1, T2, T3),
	member(data=T4, T3),
	arg(1, T4, T5),
	member(url=Url, T5),
	member(title=Title, T5),!.

fix_reddit_url(Url, Removed) :-
	atom_contains('amp;', Url),
	remove_from_atom(Url, 'amp;', Removed),!.
fix_reddit_url(Url, Removed) :-
	Removed=Url.

fix_subreddit(Subreddit, Fixed) :-
	is_list(Subreddit),
	atomic_list_concat(Subreddit, '', Fixed).
fix_subreddit(Subreddit, Fixed) :-
	Fixed=Subreddit.

top_post_html(Subreddit, Html, Title) :-
	fix_subreddit(Subreddit, Fixed),
	top_post_info(Fixed, U, Title),
	fix_reddit_url(U, Url),
	url_to_html(Url, Html).

random_post_html(Subreddit, Html, Title) :-
	fix_subreddit(Subreddit, Fixed),
	random_post_info(Fixed, U, Title),
	fix_reddit_url(U, Url),
	url_to_html(Url, Html).

get_random_sub(Url) :-
	http_open('https://www.reddit.com/r/random.json', Stream, []),
	json_read(Stream, json(List), []),
	member(data=Data, List),
	arg(1, Data, Info),
	member(children=Children, Info),
	arg(1, Children, T0),
	member(data=Url, T0).
