(* Homework #1 *)

(* 1 *)
fun is_older (x : int * int * int, y : int * int * int) =
    let fun compare_ascending (smaller : int list, larger : int list) =
	    if null smaller orelse null larger
	    then false
	    else
		if hd smaller = hd larger
		then compare_ascending (tl smaller, tl larger)
		else hd smaller < hd larger
    in compare_ascending([#1 x, #2 x, #3 x], [#1 y, #2 y, #3 y])
    end

(* 2 *)
fun is_date_in_month (date : int * int * int, month : int) =
    #2 date = month

fun number_in_month (dates : (int * int * int) list, month : int) = 
    if null dates
    then 0
    else 
	if is_date_in_month(hd dates, month)
	then 1 + number_in_month(tl dates, month)
	else number_in_month(tl dates, month)

(* 3 *)
fun number_in_months (dates : (int * int * int) list, months : int list) =
    if null months
    then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months)

(* 4 *)
fun dates_in_month (dates : (int * int * int) list, month : int) = 
    if null dates
    then []
    else
	if is_date_in_month(hd dates, month)
	then hd dates :: dates_in_month(tl dates, month)
	else dates_in_month(tl dates, month)

(* 5 *)
fun dates_in_months (dates : (int * int * int) list, months : int list) =
    if null months
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

(* 6 *)
fun get_nth (strings : string list, n : int) =
    if n = 1
    then hd strings
    else get_nth (tl strings, n - 1)

(* 7 *)
val month_names = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
fun date_to_string (date : (int * int * int)) =
    get_nth(month_names, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)

(* 8 *)
fun number_before_reaching_sum (sum : int, numbers : int list) =
    if sum - hd numbers <= 0
    then 0
    else 1 + number_before_reaching_sum(sum - hd numbers, tl numbers)

(* 9 *)
val days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
fun what_month (day : int) =
    number_before_reaching_sum(day, days_in_month) + 1

(* 10 *)
fun month_range (day1 : int, day2 : int) = 
    if day1 > day2
    then []
    else what_month(day1) :: month_range(day1 + 1, day2)

(* 11 *)
fun oldest (dates : (int * int * int) list) =
    if null dates
    then NONE
    else
	let val oldest_in_tail = oldest(tl dates)
	in if isSome oldest_in_tail andalso is_older(valOf oldest_in_tail, hd dates)
	   then oldest_in_tail
	   else SOME(hd dates)
	end

(* 12 *)
fun remove_duplicates (numbers : int list) =
    let fun contains (nums : int list, x : int) =
	    if null nums
	    then false
	    else 
		if hd nums = x
		then true
		else contains(tl nums, x)
    in
	if null numbers
	then []
	else
	    if contains(tl numbers, hd numbers)
	    then remove_duplicates(tl numbers)
	    else hd numbers :: remove_duplicates(tl numbers)
    end

fun number_in_months_challenge (dates : (int * int * int) list, months : int list) =
    number_in_months(dates, remove_duplicates(months))

fun dates_in_months_challenge (dates : (int * int * int) list, months : int list) =
    dates_in_months(dates, remove_duplicates(months))

(* 13 *)
fun reasonable_date (date : int * int * int) =
    let fun reasonable_year (year : int) =
	    year > 0
	fun reasonable_month (month : int) =
	    month > 0 andalso month < 13
	fun is_leap_year (year : int) =
	    year mod 400 = 0 orelse
	    (year mod 4 = 0 andalso year mod 100 <> 0)
	fun days_in_non_leap_month (month : int) =
	    let fun object_at_index (xs : int list, index : int) =
		    if index = 1
		    then hd xs
		    else object_at_index(tl xs, index - 1)
	    in object_at_index(days_in_month, month)
	    end
	fun valid_day (date : int * int * int) =
	    if is_date_in_month(date, 2) andalso is_leap_year(#1 date)
	    then #3 date <= 29
	    else #3 date <= days_in_non_leap_month(#2 date)
    in reasonable_year(#1 date) andalso
       reasonable_month(#2 date) andalso
       valid_day(date)
    end
