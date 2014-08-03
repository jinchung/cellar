use "hw1.sml";
(* 
Testing suite for hw1.sml 
The Good: passing test case scenarios
The Bad: edge cases and failing test case scenarios
The Ugly: performance throttling scenarios
*)

(* Testing suite tools *)
val is_older_name = "is_older"
val dates = [(1988, 4, 17), (1988, 5, 18), (1988, 5, 14)]
val months = [ 1, 2, 3, 4]
val months2 = [1, 5, 4]
val months3 = [1, 3, 5]
val months4 = []
val months5 = [9]

fun assert_true(test_name: string, result: bool) =
    if (result)
    then "PASSED : " ^ test_name
    else "FAILED : " ^ test_name

fun assert_false(test_name: string, result: bool) =
    assert_true(test_name, not result)

(* The Good, The Bad *)
fun test_is_older_year() = 
    let
	val older = (1988, 5, 17)
	val younger = (2014, 5, 17)
    in
	[assert_true("is_older_year", is_older(older, younger)),
	assert_false("is_younger", is_older(younger, older))]
    end

fun test_is_older_month() = 
    let
	val older = (2014, 5, 17)
	val younger = (2014, 6, 17)
    in
	[assert_true("is_older_month", is_older(older, younger))]
    end

fun test_is_older_day() =
    let
	val older = (2014, 5, 17)
	val younger = (2014, 5, 18)
    in
	[assert_true("is_older_day", is_older(older, younger))]
    end

fun test_is_older_mixed() = 
    let
	val older = (2014, 4, 27)
	val younger = (2014, 5, 17)
    in
	[assert_true("is_older_mixed", is_older(older, younger))]
    end

fun test_number_in_month() =
    let
	val result1 = number_in_month(dates, 5)
	val result2 = number_in_month(dates, 3)
	val result3 = number_in_month(dates, 4)
    in
	[assert_true("number_in_month_may", result1 = 2),
	assert_true("number_in_month_mar", result2 = 0),
	assert_true("number_in_month_apr", result3 = 1)]
    end

fun test_number_in_months() =
    let
	val result1 = number_in_months(dates, months)
        val result2 = number_in_months(dates, months2)
        val result3 = number_in_months(dates, months3)
        val result4 = number_in_months(dates, months4)
        val result5 = number_in_months(dates, months5)
    in
	[assert_true("number_in_months 1 2 3 4", result1 = 1),
	assert_true("number_in_months 1 5 4", result2 = 3),
	assert_true("number_in_months 1 3 5", result3 = 2),
	assert_true("number_in_months empty", result4 = 0),
	assert_true("number_in_months 9", result5 = 0)]
    end

fun test_dates_in_month() =
    let
	val expected_result1 = [(1988, 4, 17)]
	val expected_result2 = [(1988, 5, 18), (1988, 5, 14)]
	val expected_result3 = []
	val result1 = dates_in_month(dates, 4)
        val result2 = dates_in_month(dates, 5)
        val result3 = dates_in_month(dates, 1)
    in
	[assert_true("dates_in_month test1", result1 = expected_result1),
	assert_true("dates_in_month test2", result2 = expected_result2),
	assert_true("dates_in_month test3", result3 = expected_result3)]
    end

fun test_more_dates_in_months() =
    let
	val expected1 = [(1988, 4, 17)]
	val expected2 = [(1988, 5, 18), (1988, 5, 14), (1988, 4, 17)]
	val expected3 = [(1988, 5, 18), (1988, 5, 14)]
	val expected4 = []
	val expected5 = []
	val result1 = dates_in_months(dates, months)
        val result2 = dates_in_months(dates, months2)
        val result3 = dates_in_months(dates, months3)
        val result4 = dates_in_months(dates, months4)
        val result5 = dates_in_months(dates, months5)
    in
	[assert_true("dates_in_months 1234", result1 = expected1),
	assert_true("dates_in_months 154", result2 = expected2),
	assert_true("dates_in_months 135", result3 = expected3),
	assert_true("dates_in_months empty", result4 = expected4),
	assert_true("dates_in_months 9", result5 = expected5)]
    end

fun test_get_nth() =
    let
	val strings = ["First", "Second", "Third", "Fourth"]
    in
	[assert_true("", get_nth(strings, 1) = "First"),
	assert_true("", get_nth(strings, 4) = "Fourth")]
    end

fun test_date_to_string() = 
    let
	val result1 = date_to_string((1988, 5, 17))
        val result2 = date_to_string((2014, 12, 31));
    in
	[assert_true("birthday to string", result1 = "May 17, 1988"), 
	assert_true("dec 31 to string", result2 = "December 31, 2014")]
    end

fun test_number_before_reaching_sum() =
    let
	val positives = [1, 4, 7, 20]
    in
	[assert_true("number before reaching sum 1", number_before_reaching_sum(1, positives) = 1) ,
	assert_true("number before reaching sum 3", number_before_reaching_sum(3, positives) = 2)]
    end

fun test_what_month() =
    let
	val result1 = what_month(28)
        val result2 = what_month(60)
        val result3 = what_month(365)
    in
	[assert_true("day 28", result1 = 1),
        assert_true("day 60", result2 = 3),
	assert_true("last day", result3 = 12)]
    end

(* The Ugly *)
fun print_all(results: string list) = 
    if null results
    then
	""
    else
        (hd results) ^ "\n" ^ print_all(tl results)

fun run_all_tests() =
    let
	val test1 = test_is_older_year()
	val test2 = test_is_older_month()
	val test3 = test_is_older_day()
	val test4 = test_is_older_mixed()
	val test5 = test_number_in_month()
	val test6 = test_number_in_months()
	val test7 = test_dates_in_month()
	val test8 = test_more_dates_in_months()
	val test9 = test_get_nth()
	val test10 = test_date_to_string()
	val test11 = test_number_before_reaching_sum()
	val test12 = test_what_month()
	val master_list = test1 @ test2 @ test3 @ test4 @ test5 @ test6 @ test7 @ test8 @ test9 @ test10 @ test11 @ test12
    in
	master_list
    end


