(* Homework #1 tests *)

use "hw1.sml";

(* 1 *)
val birthday = (1986, 4, 25);
val today = (2014, 8, 10);
val august10 = today;
val test1_1 = is_older(birthday, today) = true;
val test1_2 = is_older(today, birthday) = false;
val test1_3 = is_older(today, august10) = false;

(* 2 *)
val date_list = [today, birthday, august10];
val test2_1 = number_in_month(date_list, 4) = 1;
val test2_2 = number_in_month(date_list, 8) = 2;

(* 3 *)
val test3_1 = number_in_months(date_list, [4, 8]) = 3;
val test3_2 = number_in_months(date_list, []) = 0;
val test3_3 = number_in_months(date_list, [1, 2, 3]) = 0;
val test3_4 = number_in_months(date_list, [8, 9, 11325]) = 2;

(* 4 *)
val test4_1 = dates_in_month(date_list, 5) = [];
val test4_2 = dates_in_month(date_list, 4) = [birthday];
val test4_3 = dates_in_month(date_list, 8) = [today, today];

(* 5 *)
val test5_1 = dates_in_months(date_list, [1, 2, 3]) = [];
val test5_2 = dates_in_months(date_list, [8]) = [today, today];
val test5_3 = dates_in_months(date_list, [4, 8]) = [birthday, today, today];

(* 6 *)
val colors = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"];
val test6_1 = get_nth(colors, 1) = "red";
val test6_2 = get_nth(colors, 7) = "violet";

(* 7 *)
val test7_1 = date_to_string(birthday) = "April 25, 1986";
val test7_2 = date_to_string(today) = "August 10, 2014";

(* 8 *)
val numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
val test8_0 = number_before_reaching_sum;
val test8_1 = number_before_reaching_sum(1, numbers) = 0;
val test8_2 = number_before_reaching_sum(15, numbers) = 4;
val test8_3 = number_before_reaching_sum(16, numbers) = 5;

(* 9 *)
val test9_1 = what_month(1) = 1;
val test9_2 = what_month(31) = 1;
val test9_3 = what_month(365) = 12;

(* 10 *)
val test10_1 = month_range(50, 49) = [];
val test10_2 = month_range(30, 33) = [1, 1, 2, 2];

(* 11 *)
val test11_1 = isSome(oldest([])) = false;
val test11_2 = valOf(oldest([today, august10])) = today;
val test11_3 = valOf(oldest(date_list)) = birthday;

(* 12 *)
val test12_1 = number_in_months_challenge(date_list, []) = 0;
val test12_2 = number_in_months_challenge(date_list, [4, 8, 4, 4, 8]) = 3;
val test12_3 = dates_in_months_challenge(date_list, []) = [];
val test12_4 = dates_in_months_challenge(date_list, [8, 8, 5, 6, 5, 8]) = [today, today];

(* 13 *)
val test13_1 = reasonable_date(birthday) = true;
val test13_2 = reasonable_date(today) = true;
val test13_3 = reasonable_date((3, 345, 48)) = false;
val test13_4 = reasonable_date((2014, 2, 29)) = false;
val test13_5 = reasonable_date((2016, 2, 29)) = true;
