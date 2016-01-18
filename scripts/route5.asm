Route5Script: ; 556b2 (15:56b2)
	jp EnableAutoTextBoxDrawing

Route5TextPointers: ; 556b5 (15:56b5)
	dw Route5Text1
	dw Route5Text2
	dw Route5Text3

Route5Text1: ; 556b7 (15:56b7)
	TX_FAR _Route5Text1
	db "@"

Route5Text2: ; 556b7 (15:56b7)
	TX_FAR _Route5Text2
	db "@"

Route5Text3:
	TX_FAR _Route5Text3
	db "@"