val days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

(* 
Assumes positive 4-digit years, 2-digit months, 2-digit dates 
Test cases:
    (1988, 5, 17), (1988, 5, 18) --> true
    (1988, 3, 17), (1988, 5, 12) --> true
    (1988, 3, 17), (1988, 1, 2) --> false
    (1988, 5, 17), (1988, 5, 17) --> false
*)
fun is_older(date1: int*int*int, date2: int*int*int) = 
    let
	val date1_val = ((#1 date1) * 1000) + ((#2 date1) * 100) + (#3 date1)
	val date2_val = ((#1 date2) * 1000) + ((#2 date2) * 100) + (#3 date2)
    in
	date1_val < date2_val
    end

fun number_in_month(dates: ((int*int*int) list), month: int) = 
    if null dates
    then 0
    else
	let 
	    val tl_ans = number_in_month(tl dates, month)
	    val curr = hd dates
	in
	    if (#2 curr = month)
	    then 1 + tl_ans
	    else tl_ans
	end

fun number_in_months(dates: ((int*int*int) list), months: int list) = 
    if (null months) then 0
    else number_in_month(dates, hd months) + number_in_months(dates, tl months)

fun dates_in_month(dates: ((int*int*int) list), month: int) =
    if (null dates) then []
    else 
	let 
	    val tl_ans = dates_in_month(tl dates, month)
	    val curr = hd dates
	in
	    if #2 curr = month
	    then curr::tl_ans 
	    else tl_ans
	end

fun dates_in_months(dates: ((int*int*int) list), months: int list) =
    if (null months) 
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth(strings: string list, n: int) =
    if (n <= 1) 
    then hd strings
    else get_nth(tl strings, n-1)

fun date_to_string(date: int*int*int) =
    let
	val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        val year = Int.toString(#1 date)
        val month = get_nth(months, #2 date)
        val day = Int.toString(#3 date)
    in
	month ^ " " ^ day ^ ", " ^ year
    end

fun number_before_reaching_sum(sum: int, positives: int list) = 
    if (hd positives >= sum)
    then 1
    else 1 + number_before_reaching_sum(sum - hd positives, tl positives)

fun what_month(day_of_year: int) =
    number_before_reaching_sum(day_of_year, days_in_month)

fun month_range(day1: int, day2: int) =
    if day2 < day1 then []
    else what_month(day1)::month_range(day1 + 1, day2)

fun oldest(dates: ((int*int*int) list)) =
    if null dates 
    then NONE
    else
	let val tl_ans = oldest(tl dates)
	in
	    if isSome tl_ans  
	    then 
		if is_older((hd dates), valOf tl_ans)
		then SOME (hd dates)
		else tl_ans
	    else SOME (hd dates)
	end

fun is_valid_year(year: int) =
    year > 0
   
fun is_valid_month(month: int) =
   month >= 1 andalso month <= 12
   
fun num_days_in_month(days_in_month: int list, month: int) =
    if (month = 1) 
    then hd days_in_month
    else num_days_in_month(tl days_in_month, month - 1)

fun is_leap_year(year: int) =
    ((year mod 400 = 0) orelse (year mod 4 = 0 andalso not(year mod 100 = 0)))

fun is_valid_day(date: int*int*int) =
    let
	val valid_days = (if #2 date = 2 then (if is_leap_year(#1 date) then 29 else 28) else num_days_in_month(days_in_month, #2 date)) 
        val day = #3 date
    in
	day > 0 andalso day <= valid_days
    end

fun reasonable_date(date: int*int*int) =
    (is_valid_year(#1 date) andalso is_valid_month(#2 date) andalso is_valid_day(#1 date, #2 date, #3 date))
