(in-package :shop2-user)

(defun define-rover-domain ()
  (let ((*define-silently* t))
    (defdomain (rover :redefine-ok t)
       (
        ;; basic operators

        (:operator (!navigate ?x ?y ?z)
                   (	(rover ?x)  (waypoint ?y)  (waypoint ?z) (can_traverse ?x ?y ?z)  (available ?x)  (at ?x ?y) (visible ?y ?z)	)
                   (	(at ?x ?y)	) 
		   (	(at ?x ?z)	) ;; (:protection (at ?x ?z))	)
        )

        (:operator (!sample_soil ?x ?s ?p)
                   (	(rover ?x) (store ?s) (waypoint ?p) (at ?x ?p) (at_soil_sample ?p) (equipped_for_soil_analysis ?x) (store_of ?s ?x) (empty ?s)	)
                   (	(empty ?s) (at_soil_sample ?p)	) ;; (:protection (at ?x ?p))	)
		   (	(full ?s) (have_soil_analysis ?x ?p)	)
	)

        (:operator (!sample_rock ?x ?s ?p)
                   (	(rover ?x) (store ?s) (waypoint ?p) (at ?x ?p) (at_rock_sample ?p) (equipped_for_rock_analysis ?x) (store_of ?s ?x) (empty ?s)	)
                   (	(empty ?s) (at_rock_sample ?p)	) ;; (:protection (at ?x ?p))	)
		   (	(full ?s) (have_rock_analysis ?x ?p)	)
	)

        (:operator (!drop ?x ?y)
                   (	(rover ?x) (store ?y) (store_of ?y ?x) (full ?y)	)
                   (	(full ?y)	)
		   (	(empty ?y)	)
	)

        (:operator (!calibrate ?r ?i ?t ?w)
                   (	(rover ?r) (camera ?i) (objective ?t) (waypoint ?w) (equipped_for_imaging ?r) (calibration_target ?i ?t) (at ?r ?w) (visible_from ?t ?w) (on_board ?i ?r)	)
                   ()
		   (	(calibrated ?i ?r)	)
	)

        (:operator (!take_image ?r ?p ?o ?i ?m)
                   (	(rover ?r) (waypoint ?p) (objective ?o) (camera ?i)(mode ?m) (calibrated ?i ?r) (on_board ?i ?r) (equipped_for_imaging ?r) (supports ?i ?m) (visible_from ?o ?p) (at ?r ?p)	)
                   (	(calibrated ?i ?r)	) ;; (:protection (at ?r ?p))	)
		   (	(have_image ?r ?o ?m)	)
	)

        (:operator (!communicate_soil_data ?r ?l ?p ?x ?y)
                   (	(rover ?r) (lander ?l) (waypoint ?p) (waypoint ?x) (waypoint ?y) (at ?r ?x) (at_lander ?l ?y) (have_soil_analysis ?r ?p) (visible ?x ?y) (available ?r) (channel_free ?l)	)
                   (	(available ?r) (channel_free ?l)	) ;; (:protection (at ?r ?x))	)
		   (	(channel_free ?l) (communicated_soil_data ?p) (available ?r)	)
	)

        (:operator (!communicate_rock_data ?r ?l ?p ?x ?y)
                   (	(rover ?r) (lander ?l) (waypoint ?p) (waypoint ?x) (waypoint ?y) (at ?r ?x) (at_lander ?l ?y) (have_rock_analysis ?r ?p) (visible ?x ?y) (available ?r) (channel_free ?l)	)
                   (	(available ?r) (channel_free ?l)	) ;; (:protection (at ?r ?x))	)
		   (	(channel_free ?l) (communicated_rock_data ?p) (available ?r)	)
	)

        (:operator (!communicate_image_data ?r ?l ?o ?m ?x ?y)
                   (	(rover ?r) (lander ?l) (objective ?o) (mode ?m) (waypoint ?x) (waypoint ?y) (at ?r ?x) (at_lander ?l ?y) (have_image ?r ?o ?m) (visible ?x ?y) (available ?r) (channel_free ?l)	)
                   (	(available ?r) (channel_free ?l)	) ;; (:protection (at ?r ?x))	)
		   (	(channel_free ?l) (communicated_image_data ?o ?m) (available ?r)	)
	)

(:operator (!!visit ?waypoint)
  ()
  ()
  ((visited ?waypoint)))

(:operator (!!unvisit ?waypoint)
  ()
  ((visited ?waypoint))
  ())

;;;        (:operator (!!add-protection ?g)
;;;                   ()
;;;                   ((:protection ?g))
;;;                   0
;;;	)

;;;        (:operator (!!delete-protection ?g)
;;;                   ((:protection ?g))
;;;                   ()
;;;                   0
;;;	)

;;;------------------------------------------------------------

;; actual AI planning methods

(:method (empty_store ?s ?rover)
((empty ?s))
()
()
((!drop ?rover ?s))
)

(:method (navigate ?rover ?to)
  ((at ?rover ?from)) ;; (different ?from ?to))
  ((!!visit ?from)
     (navigate3 ?rover ?from ?to)
     (!!unvisit ?from))

;;;  ((at ?rover ?from) (same ?from ?to))
;;;    ((:task :immediate !!add-protection (at ?rover ?to)))
)

(:method (navigate3 ?rover ?from ?to)
((at ?rover ?to))
()

((can_traverse ?rover ?from ?to))
((!navigate ?rover ?from ?to))

((can_traverse ?rover ?from ?mid)
(not (visited ?mid)))
((!navigate ?rover ?from ?mid) (!!visit ?mid) (navigate3 ?rover ?mid ?to) (!!unvisit ?mid))
)

;----------------------------------------------

(:method (send_soil_data ?rover ?waypoint)
((lander ?l) (at_lander ?l ?y) (visible ?waypoint ?y))
((!communicate_soil_data ?rover ?l ?waypoint ?waypoint ?y))

     ((lander ?l)
          (at_lander ?l ?y)
          (visible ?x ?y))
         ((navigate ?rover ?x)
      (!communicate_soil_data ?rover ?l ?waypoint ?x ?y))
)

(:method (get_soil_data ?waypoint)
    ((waypoint ?waypoint)
     (rover ?rover)
         (store_of ?s ?rover)
         (equipped_for_soil_analysis ?rover)
    )
         ((navigate ?rover ?waypoint)
          (empty_store ?s ?rover)
          (!sample_soil ?rover ?s ?waypoint)
      (send_soil_data ?rover ?waypoint))
)

(:method (send_rock_data ?rover ?waypoint)
((lander ?l) (at_lander ?l ?y) (visible ?waypoint ?y))
((!communicate_rock_data ?rover ?l ?waypoint ?waypoint ?y))

     ((lander ?l)
          (at_lander ?l ?y)
          (visible ?x ?y))
         ((navigate ?rover ?x)
      (!communicate_rock_data ?rover ?l ?waypoint ?x ?y))
)

(:method (get_rock_data ?waypoint)
    ((waypoint ?waypoint)
     (rover ?rover)
         (equipped_for_rock_analysis ?rover)
         (store_of ?s ?rover)
    )
         ((navigate ?rover ?waypoint)
          (empty_store ?s ?rover)
          (!sample_rock ?rover ?s ?waypoint)
      (send_rock_data ?rover ?waypoint))
)

(:method (send_image_data ?rover ?objective ?mode)
((lander ?l) (at_lander ?l ?y) (at ?rover ?waypoint) (visible ?waypoint ?y))
((!communicate_image_data ?rover ?l ?objective ?mode ?waypoint ?y))

     ((lander ?l)
          (at_lander ?l ?y)
          (visible ?x ?y))
         ((navigate ?rover ?x)
      (!communicate_image_data ?rover ?l ?objective ?mode ?x ?y))
)

(:method (get_image_data ?objective ?mode)
    ((objective ?objective)
         (equipped_for_imaging ?rover)
         (on_board ?camera ?rover)
         (supports ?camera ?mode)
         (visible_from ?objective ?waypoint)
    )
         ((calibrate ?rover ?camera)
      (navigate ?rover ?waypoint)
          (!take_image ?rover ?waypoint ?objective ?camera ?mode)
      (send_image_data ?rover ?objective ?mode))
)

(:method (calibrate ?rover ?camera)
    ((calibration_target ?camera ?objective)
         (visible_from ?objective ?waypoint)
    )
         ((navigate ?rover ?waypoint)
          (!calibrate ?rover ?camera ?objective ?waypoint))
)

;;;--------------------------------------------------------------

        ;; state axioms

        (:- (same ?x ?x) nil)
        (:- (different ?x ?y) ((not (same ?x ?y))))

        ))))

(eval-when (:load-toplevel)
  (define-rover-domain))



;;;--------------------------------------------------------------











