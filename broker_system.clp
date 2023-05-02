; An expert "Broker" system in the CLIPS language 

;  The system will ask the user for the following information:
;  • If he prefers small, medium or large home.
;  • In which area of Thessaloniki (East, West, Centre).
;  • New or old.
;  • Apartment building or maisonette.
;  • How many members does family.
;  • If it has car.
;  Ôhe system, after appropriate calculations, suggests one or more houses that meet the requirements of the prospective buyer, 
;  printing them on the screen in an easy-to-read manner. If there are no houses suitable for the buyer, then it prints an appropriate message.
; ---------------------------------------------------------------------------------------------------------------------------------------------

; ------------------- START OF CODE -------------------

; Define the "house" template
(deftemplate house
   (slot id (type INTEGER))       ; Define the "id" slot as an integer
   (slot area (type INTEGER))     ; Define the "area" slot as an integer
   (slot rooms (type INTEGER))    ; Define the "rooms" slot as an integer
   (slot new_old (type SYMBOL))   ; Define the "new_old" slot as a symbol
   (slot type (type SYMBOL))      ; Define the "type" slot as a symbol
   (slot parking (type SYMBOL))   ; Define the "parking" slot as a symbol
   (slot location (type SYMBOL))  ; Define the "location" slot as a symbol
   (slot price (type INTEGER))    ; Define the "price" slot as an integer
)

; Define a collection of facts about houses, with information on their characteristics such as 
; id, area, number of rooms, age, type, parking availability, location, and price. 
(deffacts houses-db
   (house (id 1) (area 95) (rooms 3) (new_old Old) (type Apartment) (parking No) (location Kalamaria) (price 190000))
   (house (id 2) (area 105) (rooms 2) (new_old Old) (type Maisonette) (parking Yes) (location Pylaia) (price 189000))
   (house (id 3) (area 111) (rooms 3) (new_old New) (type Apartment) (parking Yes) (location Toumpa) (price 177600))   
   (house (id 4) (area 84) (rooms 2) (new_old Old) (type Apartment) (parking No) (location Ano-Poli) (price 142800))
   (house (id 5) (area 97) (rooms 2) (new_old New) (type Maisonette) (parking No) (location Agios-Pavlos) (price 145500))
   (house (id 6) (area 93) (rooms 2) (new_old New) (type Apartment) (parking No) (location Sykies) (price 120900))
   (house (id 7) (area 120) (rooms 3) (new_old New) (type Maisonette) (parking No) (location Stavroupoli) (price 144000))
   (house (id 8) (area 130) (rooms 4) (new_old New) (type Apartment) (parking Yes) (location Evosmos) (price 130000))
   (house (id 9) (area 92) (rooms 2) (new_old Old) (type Apartment) (parking No) (location Menemeni) (price 128800))
   (house (id 10) (area 115) (rooms 3) (new_old New) (type Apartment) (parking Yes) (location Pylaia) (price 210000))
)

; The rule 'get-user-input' gets user inputs and asserts them as facts into the working memory,
; I use while loops in case of wrong input in each question.
(defrule get-user-input
   =>
   ; QUESTION 1
   (printout t "Do you want a small, medium or large house?: ")
   (bind ?size (read))   ; value input from the user.
   (if (or (eq ?size small) (eq ?size medium) (eq ?size large)) then ; check if the input is valid.
       (assert (input-size ?size)) ; assert the user's input as a fact if it's valid.
    else
       (while (or (not (eq ?size small)) (not (eq ?size medium)) (not (eq ?size large))) do   ; Start the while-loop as long as the user gives a wrong input value.
           (printout t "Wrong input! Please enter (small or medium or large): ") ; Print an error message.
           (bind ?size (read)) ; value input from the user.
           (if (or (eq ?size small) (eq ?size medium) (eq ?size large)) then ; check if the input is valid.
               (assert (input-size ?size)) ; assert the user's input as a fact if it's valid.
               (break)   ; exit the loop if the input is valid.
           ) ; end of if statement.
       ) ; end of while-loop.
   ) ; end of if statement.

   ; QUESTION 2
   (printout t "In which location do you want the house? (east/center/west): ")
   (bind ?location (read)) ; value input from the user.
   (if (or (eq ?location east) (eq ?location center) (eq ?location west)) then ; check if the input is valid.
       (assert (input-location ?location))  ; assert the user's input as a fact if it's valid.
     else
      (while (or (not (eq ?location east)) (not (eq ?location center)) (not (eq ?location west))) do ; Start the while-loop as long as the user gives a wrong input value.
          (printout t "Wrong input! Please enter (east or center or west): ") ; Print an error message.
          (bind ?location (read)) ; value input from the user.
          (if (or (eq ?location east) (eq ?location center) (eq ?location west)) then ; check again if the input is valid.
              (assert (input-location ?location)) ; assert the user's input as a fact if it's valid.
              (break)   ; exit the loop if the input is valid.
          ) ; end of if statement.
      ) ; end of while loop.
   ) ; end of if statement.

   ; QUESTION 3
   (printout t "Do you want new or old house? (yes/no): ")
   (bind ?new_old (read)) ; value input from the user.
   (if (or (eq ?new_old yes) (eq ?new_old no)) then ; check if the input is valid.
      (assert (input-new_old ?new_old)) ; assert user's input on new_old as a fact.
     else
      (while (or (not (eq ?new_old yes)) (not (eq ?new_old no))) do ; Start the while-loop as long as the user gives a wrong input value.
         (printout t "Wrong input! Please enter (yes or no): ") ; Print an error message.
         (bind ?new_old (read))   ; value input from the user.
         (if (or (eq ?new_old yes) (eq ?new_old no)) then ; check again if the input is valid.
             (assert (input-new_old ?new_old)) ; assert user's input on new_old as a fact.
             (break) ; exit the loop if the input is valid.
         ) ; end of if statement.
      ) ; end of while loop.
   ) ; end of if statement.

   ; QUESTION 4
   (printout t "Apartment or Maisonette? (a/m): ")
   (bind ?type (read)) ; value input from the user.
   (if (or (eq ?type a) (eq ?type m)) then ; check if the input is valid.
       (assert (input-type ?type)) ; assert user's input on new_old as a fact.
     else
       (while (or (not (eq ?type a)) (not (eq ?type m))) do ; Start the while-loop as long as the user gives a wrong input value.
          (printout t "Wrong input! Please enter (a or m): ") ; Print an error message.
          (bind ?type (read))   ; value input from the user.
          (if (or (eq ?type a) (eq ?type m)) then ; check again if the input is valid.
              (assert (input-type ?type)) ; assert user's input on type as a fact.
              (break)   ; exit the loop if the input is valid.
          ) ; end of if statement.
       ) ; end of while loop.
   ) ; end of if statement.
   
   ; QUESTION 5
   (printout t "How many members has your family? (integer): ")
   (bind ?members (read)) ; value input from the user.
   (while (not (numberp ?members)) do ; Start the while-loop as long as the user gives a wrong input value. 'numberp' is a built-in function in CLIPS, that checks if its argument is a numeric value
      (printout t "Wrong input! Please enter an integer (e.g. 3): ") ; Print an error message.
      (bind ?members (read)) ; value input from the user.
      (if (numberp ?members) then ; check if the input is now a number.
         (break) ; exit the loop if the input is number.
      ) ; end of if statement
   ) ; end of while loop   
   (assert (input-members ?members)) ; assert user's input on family members as a fact.

   ; QUESTION 6
   (printout t "Do you have a car? (yes/no): ")
   (bind ?parking (read)) ; value input from the user.
   (if (or (eq ?parking yes) (eq ?parking no)) then ; check if the input is valid.
       (assert (input-parking ?parking)) ; assert user's input on new_old as a fact.
     else      
      (while (or (not (eq ?parking yes)) (not (eq ?parking no))) do ; Start the while-loop as long as the user gives a wrong input value.
         (printout t "Wrong input! Please enter (yes or no): ") ; Print an error message
         (bind ?parking (read)) ; value input from the user.
         (if (or (eq ?parking yes) (eq ?parking no)) then ; check again if the input is valid.
             (assert (input-parking ?parking)) ; assert user's input on parking as a fact.
             (break) ; exit the loop if the input is valid.
         ) ; end of if statement.
      ) ; end of while loop.
   ) ; end of if statement.
)

; This is a global variable that is initialized to 0. 
; It will be used to rules 'print-house-details' and 'no-matching-houses'.
(defglobal ?*count* = 0)

(defrule calculations
   ; retrieve user inputs.
   (input-size ?users_size)
   (input-location ?users_location)
   (input-new_old ?users_new_old)
   (input-type ?users_type)
   (input-members ?users_members)
   (input-parking ?users_parking)
   =>

   ; calculate area based on size and number of members given by the user.
   (bind ?users_small_area (* 25 ?users_members)) ; calculate the minimum area
   (bind ?users_large_area (* 35 ?users_members)) ; calculate the maximum area
   (assert (calculated-low-area ?users_small_area)) ; assert calculated-low-area on users_small_area as a fact.
   (assert (calculated-max-area ?users_large_area)) ; assert calculated-max-area on users_large_area as a fact.
      
   ; Calculate maximum number of bedrooms.
   (bind ?num_max_bedrooms 0) ; variable num_max_bedrooms initialized to 0.
   (if (eq ?users_members 2) then
       (bind ?num_max_bedrooms 2)
     else
      (if (> ?users_members 2) then 
          (bind ?num_max_bedrooms (- ?users_members 1)) ; The maximum number of bedrooms is the family members minus 1.
      ) ; end of if statement
   ) ; end of if statement
   (assert (calculated-max-bedrooms ?num_max_bedrooms)) ; assert calculated-max-bedrooms on num_max_bedrooms as a fact.
   
   ; Calculate minimum number of bedrooms.
   (bind ?num_min_bedrooms 2) ; The minimum number of bedrooms.
   (if (eq ?users_members 2) then
       (bind ?num_min_bedrooms 2)
   )
   (assert (calculated-min-bedrooms ?num_min_bedrooms)) ; assert user's input on num_min_bedrooms as a fact.

   ; determine the suitable location based on the user's input.
   (if (eq ?users_location east) then
       (assert (suitable_city Kalamaria or Pylaia or Toumpa)) ; assert user's input on suitable_city as a fact.
     else
       (if (eq ?users_location center) then
           (assert (suitable_city Ano-Poli or Agios-Pavlos or Sykies)) ; assert user's input on suitable_city as a fact.
         else
           (if (eq ?users_location west) then
               (assert (suitable_city Stavroupoli or Evosmos or Menemeni)) ; assert user's input on suitable_city as a fact.
           ) ; end of if statement.
       ) ; end of if statement.
   ) ; end of if statement.
   (assert (calculated-location ?users_location)) ; assert calculated-location on users_location as a fact.
   
   ; determine parking availability based on user input.
   (if (eq ?users_parking yes) then
       (bind ?users_parking Yes) ; set the value of the variable users_parking to 'Yes'.
     else
       (bind ?users_parking No) ; set the value of the variable users_parking to 'No'.
   ) ; end of if statement.
   (assert (calculated-parking ?users_parking)) ; assert calculated-parking on users_parking as a fact.
   
   ; determine whether property is new or old based on user input.
   (if (eq ?users_new_old yes) then
       (bind ?users_new_old New) ; set the value of the variable users_new_old to 'New'.
     else 
       if (eq ?users_new_old no) then
       (bind ?users_new_old Old) ; set the value of the variable users_new_old to 'Old'.
   ) ; end of if statement.
      
   ; determine property type based on user input.
   (if (eq ?users_type p) then
       (bind ?users_type Apartment) ; set the value of the variable users_type to 'Apartment'.
     else
       (if (eq ?users_type m) then
           (bind ?users_type Maisonette) ; set the value of the variable users_type to 'Maisonette'.
       ) ; end of if statement.
   ) ; end of if statement.
   
   (assert (calculated-type ?users_type)) ; assert calculated-type on users_type as a fact.
   (assert (calculated-new-old ?users_new_old)) ; assert calculated-new-old on users_new_old as a fact.
)

; Print out the proposed houses.
(defrule print-house-details
  ; Check if all required parameters have been calculated.
  (calculated-parking ?users_parking)
  (calculated-new-old ?users_new_old)
  (calculated-min-bedrooms ?num_min_bedrooms)
  (calculated-max-bedrooms ?num_max_bedrooms)
  (calculated-type ?users_type)
  (calculated-location ?users_location)
  
  (input-size ?users_size)
  (calculated-low-area ?users_small_area)
  (calculated-max-area ?users_large_area)
  
  ; Check if there's a house that matches the user's requirements.
  (house (id ?id) (type ?type) (location ?location) (area ?area) (rooms ?rooms) (new_old ?new_old) (parking ?parking) (price ?price)) ; Find a house that matches the user's requirements, based on its characteristics such as ID, type, location, area, number of rooms, age, parking, and price.
  (test (and (or (eq ?users_location east) (eq ?users_location center) (eq ?users_location west)) ; Check if the house is located in a suitable location.
             (or (and (eq ?users_location east)
                      (or (eq ?location Toumpa) (eq ?location Kalamaria) (eq ?location Pylaia))
                 ) ; end of and 
                 (and (eq ?users_location center)
                      (or (eq ?location Ano-Poli) (eq ?location Sykies) (eq ?location Agios-Pavlos))
                 ) ; end of and
                 (and (eq ?users_location west)
                      (or (eq ?location Stavroupoli) (eq ?location Evosmos) (eq ?location Menemeni))
                 ) ; end of and
              ) ; end of or
         
              (and (or (eq ?users_size small) (eq ?users_size medium) (eq ?users_size large)) ; Check the area.
	           (or (and (eq ?users_size small)
	                    (< ?area ?users_small_area))
	               (and (eq ?users_size medium)
	                    (and (>= ?area ?users_small_area) (<= ?area ?users_large_area)))
	               (and (eq ?users_size large)
	                    (> ?area ?users_large_area))
	           ) ; end of or
	      ); end of and
	      
	      (or (<= ?rooms ?num_max_bedrooms) (>= ?rooms ?num_min_bedrooms)) ; Check the maximum and the minimum number of bedrooms per person.

              (eq ?parking ?users_parking)    ; Check if the house has a parking.
              (eq ?type ?users_type)          ; Check if the house type matches the user's requirement.
              (eq ?new_old ?users_new_old)    ; Check if the house is new or old.
                 
        ) ; end of and
  ) ; end of test
  =>
  ; Print out the details of the suitable house.
  (printout t crlf "Á suitable house for you is the no" ?id crlf)
  (printout t "Area: " ?area crlf "Rooms: " ?rooms crlf "Age: " ?new_old crlf "Type: " ?type crlf "Parking: " ?parking crlf "City: " ?location crlf "Price: " ?price crlf)
    
  ; Update the count of suitable houses.
  ; If the count number increases, it means that at least one house was found that matches the user's requirements.
  (bind ?*count* (+ ?*count* 1))
)

(defrule no-matching-houses
  ; Check if all required parameters have been calculated.
  (calculated-parking ?users_parking)
  (calculated-new-old ?users_new_old)
  (calculated-min-bedrooms ?num_min_bedrooms)
  (calculated-max-bedrooms ?num_max_bedrooms)
  (calculated-type ?users_type)   
  (calculated-location ?users_location)
  
  (calculated-low-area ?users_small_area)
  (calculated-max-area ?users_large_area)
  =>
  ; Check if there are no houses that match the user's requirements.
  ; If count is zero then no house was found matching the user's requirement.
  (if (eq ?*count* 0) then 
    (printout t crlf "Ôhere is no house that fits the specifications." crlf)
  ) ; end of if statement
)

; ------------------- END OF CODE -------------------