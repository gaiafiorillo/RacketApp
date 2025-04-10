#lang racket
(require racket/gui/base)

; main frame
(define myframe (new frame%
                     [label "Main Frame"]
                     [width 600]
                     [height 400]))


; main container panel to manage switching views
(define main-panel (new panel% [parent myframe]))

; function to clear the current panel only if children exist (to keep everything in the same panel)
(define (clear-main-panel)
  (let ([children (send main-panel get-children)])
    (when (not (empty? children))
      (for ([child children])
        (send main-panel delete-child child)))))



; BAND or FAN? First Page
  
 (define (create-panel1)
  (clear-main-panel)
  
  (define panel1 (new vertical-panel% [parent main-panel]))
  
  (new message% [label "Are You?"]
                [parent panel1])
   
  (new button% [label "Fan"]
       [parent panel1]
       [callback (lambda (button event) (create-fan-log-in-panel))])
  
(new button% [label "Band"]
       [parent panel1]
       [callback (lambda (button event) (create-band-log-in-panel))]))


; FAN LOG IN PANEL

;Fans struct
(struct user_fans (username first_name surname password selected_concerts) #:mutable)

(define fans (set))

; creating new fan
(define add-fan (λ  (fans fan)
  (cond
    [ (set-member? fans fan)
        (printf "Fan with username ~a already exists.\n" (user_fans-username fan))
        fans] 
      [else (set-add fans fan)]
      )))

;Helper function to add a fan
(define add-to-set-of-fans (λ (fans username first_name surname password)
  (set-add fans
           (user_fans username first_name surname password '()))))

;making accounts
;(set! fans (add-to-set-of-fans fans "leeinuk" "Lee" "Nystuen" 123))
;(set! fans (add-to-set-of-fans fans "musiclover" "Be" "Gone" 3421))
;(set! fans (add-to-set-of-fans fans "hello" "Why" "Bro" "suhseid"))

; Display fans
(define display-fans (λ (fans)
  (for ([fan (in-set fans)])
    (printf "Username: ~a, First Name: ~a, Surname: ~a, Password: ~a\n"
            (user_fans-username fan)
            (user_fans-first_name fan)
            (user_fans-surname fan)
            (user_fans-password fan)))))





;LOG-IN AND SIGN-UP PANEL

(define (create-fan-log-in-panel)
  (clear-main-panel)

  (define fan-log-in-panel (new vertical-panel% [parent main-panel]))

  ;User detaisl
  (define username-field (new text-field% [label "Enter Username"] [parent fan-log-in-panel]))
  (define password-field (new text-field% [label "Enter Password"] [parent fan-log-in-panel]))
  (define first-name-field (new text-field% [label "Enter First Name"] [parent fan-log-in-panel]))
  (define surname-field (new text-field% [label "Enter Surname"] [parent fan-log-in-panel]))

 ; Signup button
(new button%
     [label "Sign Up"]
     [parent fan-log-in-panel]
     [callback (lambda (button event)
               
                 (set! fans
                       (add-to-set-of-fans
                        fans 
                        (send username-field get-value)
                        (send first-name-field get-value)
                        (send surname-field get-value)
                        (send password-field get-value)))
                
                 (display-fans fans)
               
                 (create-fanpanel))])


  ; Back button
  (new button%
       [label "Back"]
       [parent fan-log-in-panel]
       [callback (lambda (button event) (create-panel1))]))




;BAND LOG IN PANEL

(define bands (set)) 

; to store the current band name
(define current-band-name "")

; function to add a band to the set
(define (add-to-set-of-bands bands username band-name genre password)
  (set-add bands
           (user_fans username band-name genre password '())))

;display bands
(define (display-bands bands)
  (for ([band (in-set bands)])
    (printf "Username: ~a, Band Name: ~a, Genre: ~a, Password: ~a\n"
            (user_fans-username band)
            (user_fans-first_name band) 
            (user_fans-surname band)   
            (user_fans-password band))))

;Bands struct
(struct user_bands (username band-name genre password selected_concerts) #:mutable)

; create band log in panel
(define (create-band-log-in-panel)
  (clear-main-panel)

  ;Band login
  (define band-log-in-panel (new vertical-panel% [parent main-panel]))

  (define username-field (new text-field% [label "Enter username"] [parent band-log-in-panel]))
  (define band-name-field (new text-field% [label "Enter band name"] [parent band-log-in-panel]))
  (define genre-field (new text-field% [label "Enter genre"] [parent band-log-in-panel]))
  (define password-field (new text-field% [label "Enter password"] [parent band-log-in-panel]))

 (new button% [label "Sign Up"]
     [parent band-log-in-panel]
     [callback 
      (lambda (button event)
        
        (set! current-band-name (send band-name-field get-value))

        ; Add the band to the set 
        (set! bands
              (add-to-set-of-bands
               bands
               (send username-field get-value)
               (send band-name-field get-value)
               (send genre-field get-value)
               (send password-field get-value)))

        
        (create-bandpanel))])


  ; Back button
  (new button%
       [label "Back"]
       [parent band-log-in-panel]
       [callback (lambda (button event) (create-panel1))]))




;FAN PANEL 
(define (create-fanpanel)
  (clear-main-panel)

  (define fanpanel (new vertical-panel% [parent main-panel]))

  (new message% [label "FAN PANEL"]
                [parent fanpanel])

  ; Search field
  (define search-field
    (new text-field%
         [parent fanpanel]
         [label "Search: "]))

  ; Search results
  (define results-panel
    (new vertical-panel%
         [parent fanpanel]))

  ; Button to search
  (define search-button
    (new button%
         [parent fanpanel]
         [label "Search Concerts"]
         [callback
          (λ (button event)
           
            (define search-term (send search-field get-value))
            (define results (search list-of-listings search-term))

            ; Get results
            (if (empty? results)
                (new message% [parent results-panel]
                         [label "Invalid Search"])
                (for-each
                 (λ (listing)
                   (define concert-panel
                     (new horizontal-panel%
                          [parent results-panel]))
                  
                   (new message%
                        [parent concert-panel]
                        [label (string-append 
                                "Name: " (listings-name listing)
                                ", Date: " (listings-date listing)
                                ", Time: " (listings-time listing)
                                ", Venue: " (listings-venue listing)
                                ", Cost " (listings-cost listing))])

                   ; add to Favorites button
                   (new button%
                        [parent concert-panel]
                        [label "Add to Favorites"]
                        [callback
                         (λ (button event)
                           (add-selected-concert fans listing))]))
                 results))

            ; Clear all searches
            (send search-field set-value ""))]))


  ; View favorites button
  (new button%
       [label "View Favorites"]
       [parent fanpanel]
       [callback (λ (button event) (create-favorites-panel))]) ; I changed this so that it does not need the username here because it wasn't working

 ; View all concerts button
    (new button%
         [label "All Concerts"]
         [parent fanpanel]
         [callback (λ (button event) (create-all-panel))])
  
  ; Back button
  (new button%
       [label "Back"]
       [parent fanpanel]
       [callback (λ (button event) (create-fan-log-in-panel))]))

  
; list of listings global
(define list-of-listings '())

(struct listings (name date time venue cost status) #:mutable)

;functions to add and display listings to the global list
(define add-lol
  (lambda (field1 field2 field3 field4 field5 field6)
    (let ((new-listing (listings field1 field2 field3 field4 field5 field6)))
      (set! list-of-listings (cons new-listing list-of-listings)))))

(define display-listing
  (lambda (list-listing)
    (cond
     ((not (equal? (length list-listing) 0))
      (printf "Name : ~a, Date : ~a, Time : ~a, Venue : ~a, Cost : ~a, Status: ~a \n"
              (listings-name (first list-listing))
              (listings-date (first list-listing))
              (listings-time (first list-listing))
              (listings-venue (first list-listing))
              (listings-cost (first list-listing))
              (listings-status (first list-listing)))
      (display-listing (rest list-listing))))))


; function to add a concert to all fans' favorites
(define add-selected-concert
  (λ (fans concert)
    (for/fold ([updated-fans (set)]) 
              ([fan (in-set fans)])
      (let ([selected (user_fans-selected_concerts fan)]) 
        (if (member concert selected)
            (begin
              (printf "Concert already in favourites: ~a on ~a at ~a.\n"
                      (listings-name concert)
                      (listings-date concert)
                      (listings-venue concert))
              (set-add updated-fans fan)) 
            (begin
              (set-user_fans-selected_concerts! fan (cons concert selected))
              (printf "Concert added: ~a on ~a at ~a.\n"
                      (listings-name concert)
                      (listings-date concert)
                      (listings-venue concert))
              (set-add updated-fans fan))))))) 


;FAVOURITES PANEL
(define (create-favorites-panel)
  (clear-main-panel)

  (define favorites-panel (new vertical-panel% [parent main-panel]))

  (new message% [label "Favorites"]
               [parent favorites-panel])

  ;Get the list of all favorite concerts from all fans
  (define favorites
    (if (empty? fans)
        '()
        (apply append (map user_fans-selected_concerts (set->list fans)))))

  ;Display favorite concerts
  (if (empty? favorites)
      (new message% [label "No favorites added yet."]
                   [parent favorites-panel])
      (for-each
       (λ (concert)
         (define concert-panel
           (new horizontal-panel%
                [parent favorites-panel]))
        
         (new message%
              [parent concert-panel]
              [label (string-append 
                      "Name: " (listings-name concert)
                      ", Date: " (listings-date concert)
                      ", Time: " (listings-time concert)
                      ", Venue: " (listings-venue concert)
                      ", Cost: " (listings-cost concert))])

         ;Button to remove concert from favorites
         (new button%
              [parent concert-panel]
              [label "Remove"]
              [callback
               (λ (button event)
                 (remove-selected-concert concert)
                 (create-favorites-panel))]))
       favorites))

  ;Back button
  (new button%
       [label "Back"]
       [parent favorites-panel]
       [callback (λ (button event) (create-fanpanel))]))


;function to remove a concert from all favorites
(define (remove-selected-concert concert-to-remove)
  (for-each
   (λ (fan)
     (let ([updated-list
            (filter (λ (concert)
                      (not (and (equal? (listings-name concert)
                                        (listings-name concert-to-remove))
                                (equal? (listings-date concert)
                                        (listings-date concert-to-remove)))))
                    (user_fans-selected_concerts fan))])
       (set-user_fans-selected_concerts! fan updated-list)
       (printf "Concert removed: ~a on ~a at ~a.\n"
               (listings-name concert-to-remove)
               (listings-date concert-to-remove)
               (listings-venue concert-to-remove))))
   (set->list fans))) 


;ALL CONCERTS LIST PANEL

(define (create-all-panel)
  (clear-main-panel)

  (define all-panel (new vertical-panel% [parent main-panel]))
  
  (new message% [label "All Listed Concerts"]
               [parent all-panel])

  ; Fuction to display all listings
  (if (empty? list-of-listings)
      (new message% [label "No concerts available."]
               [parent all-panel])
      (for-each
       (λ (concert)
         (define concert-panel
           (new horizontal-panel%
                [parent all-panel]))
         (new message%
              [parent concert-panel]
              [label (string-append 
                      "Name: " (listings-name concert)
                      ", Date: " (listings-date concert)
                      ", Time: " (listings-time concert)
                      ", Venue: " (listings-venue concert)
                      ", Cost: " (listings-cost concert)
                      ", Status: " (listings-status concert))]))
       list-of-listings))

  ;Back button
  (new button%
       [label "Back"]
       [parent all-panel]
       [callback (λ (button event) (create-fanpanel))]))


; BANDS PANEL

(define (create-bandpanel)
  (clear-main-panel)

  (define bandpanel
    (new vertical-panel%
         [parent main-panel]))
 
  (new message%
       [label "Create a Listing"]
       [parent bandpanel])

 ; Create a text field for the band name and pre-fill it with the current band name
  ; (this makes it so that you dont have to type the band name again)
(define name-field 
  (new text-field% 
       [label "Band Name"] 
       [parent bandpanel]))
(send name-field set-value current-band-name)
(send name-field enable #f) 

(define date-field (new text-field%
                        [label "Date"]
                        [parent bandpanel]))
(define time-field (new text-field%
                        [label "Time"]
                        [parent bandpanel]))
(define venue-field (new text-field%
                         [label "Venue"]
                         [parent bandpanel]))
(define cost-field (new text-field%
                        [label "Cost"]
                        [parent bandpanel]))
(define status-field (new choice%
                          [label "Status"]
                          [parent bandpanel]
                          [choices '("Available" "Fully Booked" "Cancelled")]))


  ;Add Listing button
  (new button%
       [label "Add Listing"]
       [parent bandpanel]
       [callback (lambda (button event)
                   (define name-value
                     (send name-field get-value))
                   (define date-value
                     (send date-field get-value))
                   (define time-value
                     (send time-field get-value))
                   (define venue-value
                     (send venue-field get-value))
                   (define cost-value
                     (send cost-field get-value))
                   (define status-value
                     (send status-field get-string-selection))
                  

; Add to global list of listings
(add-lol name-value date-value time-value venue-value cost-value status-value)

   ; clear input fields
   (send name-field set-value "")
   (send date-field set-value "")
   (send time-field set-value "")
   (send venue-field set-value "")
   (send cost-field set-value "")
                   

 ;Show the current listings
(printf "Current Listings after adding: ~a\n" list-of-listings))])

  ; "My listings" Button 
  (new button%
     [label "My Listings"]
     [parent bandpanel]
     [callback (lambda (button event)
                (create-listings-panel))])

  ;back button 
  (new button%
       [label "Back"]
       [parent bandpanel]
       [callback (lambda (button event) (create-panel1))]))

;listings panel

(define (create-listings-panel)
  (clear-main-panel) 

;Panel to display the listings
(define listings-panel (new vertical-panel%
                              [parent main-panel]))

  
  (new message%
       [label "Current Listings"]
       [parent listings-panel])



  ;Choice listing widget
  (define choice-widget
  (new choice%
       [parent listings-panel]
       [label "Select a Listing"] 
       [choices (map listings-date list-of-listings)]))
  
   

   ;Edit button
  (define edit-button
  (new button%
       [parent listings-panel]
       [label "Edit"]
       [callback (lambda (button event)
                  (define selected-index
                    (send choice-widget get-selection)) 
                  (define selected-name
                    (list-ref (map listings-name list-of-listings) selected-index)) 
                  (define selected-listing
                    (find-listing selected-name))  
                 
                  (send name-field set-value (listings-name selected-listing))
                  (send date-field set-value (listings-date selected-listing))
                  (send time-field set-value (listings-time selected-listing))
                  (send venue-field set-value (listings-venue selected-listing))
                  (send cost-field set-value (listings-cost selected-listing))
                   )]))

   ;Change status
  (define status-choice
  (new choice%
       [parent listings-panel]
       [label "Status"]
       [choices '("Avaliable" "Fully Booked" "Cancelled")]))



  
 ;input fields
  (define name-field
    (new text-field%
         [parent listings-panel]
         [label "Band Name"]))
  (define date-field
    (new text-field%
         [parent listings-panel]
         [label "Date"]))
  (define time-field
    (new text-field%
         [parent listings-panel]
         [label "Time"]))
  (define venue-field
    (new text-field%
         [parent listings-panel]
         [label "Venue"]))
  (define cost-field
    (new text-field%
         [parent listings-panel]
         [label "Cost"]))

  ; "Save" button
 (define save-button
  (new button%
       [parent listings-panel]
       [label "Save"]
       [callback (lambda (button event)
                 
                  (define selected-index (send choice-widget get-selection))
                  
                 
                  (define updated-name (send name-field get-value))
                  (define updated-date (send date-field get-value))
                  (define updated-time (send time-field get-value))
                  (define updated-venue (send venue-field get-value))
                  (define updated-cost (send cost-field get-value))
                   (define updated-status (send status-choice get-string-selection))

                  (define selected-name (list-ref (map listings-name list-of-listings) selected-index))

                  (define selected-listing (find-listing selected-name))

                  (set-listings-name! selected-listing updated-name)
                  (set-listings-date! selected-listing updated-date)
                  (set-listings-time! selected-listing updated-time)
                  (set-listings-venue! selected-listing updated-venue)
                  (set-listings-cost! selected-listing updated-cost)
                   (set-listings-status! selected-listing updated-status)

                  
                  (new message% [parent listings-panel] [label "Listing updated successfully!"])

                
                  (create-listings-panel))]))

  (new button%
       [label "Back"]
       [parent listings-panel]
       [callback (lambda (button event)
                   (create-bandpanel))]))  

; Function to find the listing by name
(define (find-listing band-name)
  (define (helper y x)
    (cond
      [(empty? y) '()]  
      [(string=? (listings-name (first y)) band-name) (first y)]
      [else (helper (rest y) (+ x 1))])) 

  (helper list-of-listings 0))  


; Function to update the listing
(define (update-listing old-name new-name new-date new-time new-venue new-cost)
  (define (helper x)
    (cond
      [(empty? x) '()]  
      [(string=? (listings-name (first x)) old-name)
       (set-listings-name! (first x) new-name)
       (set-listings-date! (first x) new-date)
       (set-listings-time! (first x) new-time)
       (set-listings-venue! (first x) new-venue)
       (set-listings-cost! (first x) new-cost)] 
      [else (helper (rest x))]))  
  (helper list-of-listings))



;The search function itself, checking band name and venue
(define (search x target-search)
  (define (searcher x)
    (cond
      [(empty? x) '()]
      [(or (string=? (listings-name (first x)) target-search)
      (string=? (listings-venue (first x)) target-search))
       (cons (first x) (searcher (rest x)))]
      [else (searcher (rest x))]))
  (searcher x))





; Start panel
(create-panel1)

; show the frame
(send myframe show #t)


