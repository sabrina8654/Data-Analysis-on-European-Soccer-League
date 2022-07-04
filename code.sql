use soccer;

select * from coach;
select * from team;
select * from player;
select * from player_in_out;
select * from match_;
select * from referee;


# is every team has only one coach
select t.team_id, count(coach_id) as cnt
from team t
left join coach c
on(t.team_id=c.team_id)
group by t.team_id
having cnt>1;

# the team choose which coaches
select team_id,coach_name
from coach 
where team_id in (select t.team_id
from team t
left join coach c
on(t.team_id=c.team_id)
group by t.team_id
having count(coach_id)>1);

# how did team 1210 do
select match_no, play_stage, results, play_date
from match_
where match_no in(select match_no
from player_in_out
where team_id=1210);


# average age of every team
select team_id, round(avg(age),0) as avg_age
from player
group by team_id
order by avg_age desc;

# the top 5 club most players are from
select playing_club, count(player_id) as cnt_player
from player
group by playing_club
order by cnt_player desc
limit 5;

# The team with the most wins and the most popular team
select team_id, count(results) as Win, 
round(avg(audence),2) as AverageAudience
from match_ 
left join player_in_out
on match_.match_no = player_in_out.match_no
where results = 'win'
group by team_id
order by win desc;
