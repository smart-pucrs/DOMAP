(define (problem floodsp01) (:domain Floods)
(:objects
	cdm1 cdm2 - cdm
	ugv1Store ugv2Store ugv3Store usv1Store usv2Store usv3Store - store
	area1 area2 area3 area4 area5 area6 area7 area8 area9 area10 area11 area12 area13 area14 area15 - area
	disaster1 disaster2 disaster3 disaster4 disaster5 - disaster
	box1 box2 - box

	(:private uav1
		uav1 - uav
	)

	(:private uav2
		uav2 - uav
	)

	(:private uav3
		uav3 - uav
	)

	(:private ugv1
		ugv1 - ugv
	)

	(:private ugv2
		ugv2 - ugv
	)

	(:private ugv3
		ugv3 - ugv
	)

	(:private usv1
		usv1 - usv
	)

	(:private usv2
		usv2 - usv
	)

	(:private usv3
		usv3 - usv
	)

	)
(:init
	(store_of ugv1Store ugv1)
	(store_of ugv2Store ugv2)
	(store_of ugv3Store ugv3)
	(store_of usv1Store usv1)
	(store_of usv2Store usv2)
	(store_of usv3Store usv3)
	(empty ugv1Store)
	(empty ugv2Store)
	(empty ugv3Store)
	(empty usv1Store)
	(empty usv2Store)
	(empty usv3Store)
	(cdm_at cdm1 area1)
	(cdm_at cdm2 area13)
	(at uav1 area1)
	(at uav2 area1)
	(at uav3 area13)
	(at usv1 area1)
	(at usv2 area1)
	(at usv3 area13)
	(at ugv1 area1)
	(at ugv2 area1)
	(at ugv3 area13)
	(box_at_cdm box1 cdm1)
	(box_at_cdm box2 cdm2)
	(water_path area1 area2)
	(water_path area2 area1)
	(water_path area2 area4)
	(water_path area4 area2)
	(water_path area2 area6)
	(water_path area6 area2)
	(water_path area4 area5)
	(water_path area5 area4)
	(water_path area4 area9)
	(water_path area9 area4)
	(water_path area9 area8)
	(water_path area8 area9)
	(water_path area8 area7)
	(water_path area7 area8)
	(water_path area6 area12)
	(water_path area12 area6)
	(water_path area12 area10)
	(water_path area10 area12)
	(water_path area9 area13)
	(water_path area13 area9)
	(water_path area2 area14)
	(water_path area14 area2)

	(ground_path area1 area3)
	(ground_path area3 area1)
	(ground_path area3 area4)
	(ground_path area4 area3)
	(ground_path area3 area5)
	(ground_path area5 area3)
	(ground_path area4 area6)
	(ground_path area6 area4)
	(ground_path area4 area10)
	(ground_path area10 area4)
	(ground_path area10 area7)
	(ground_path area7 area10)
	(ground_path area7 area8)
	(ground_path area8 area7)
	(ground_path area5 area11)
	(ground_path area11 area5)
	(ground_path area11 area9)
	(ground_path area9 area11)
	(ground_path area10 area13)
	(ground_path area13 area10)
	(ground_path area3 area15)
	(ground_path area15 area3)

	(visible_from disaster1 area8)
	(visible_from disaster2 area12)
	(visible_from disaster3 area10)
	(visible_from disaster4 area7)
	(visible_from disaster5 area3)

	(in_range area2 area1)
	(in_range area3 area1)
	(in_range area1 area1)
	(in_range area9 area13)
	(in_range area10 area13)
	(in_range area13 area13)
)

(:goal (and
(communicated_data disaster1)
(communicated_data disaster2)
(communicated_data disaster3)
(communicated_data disaster4)
(communicated_data disaster5)
(box_at_area box1 area9)
(box_at_area box2 area11)
(have_water_sample_cdm cdm2 area8)
(have_water_sample_cdm cdm1 area9)
	)
)

)
