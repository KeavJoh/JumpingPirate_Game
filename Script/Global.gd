extends Node

var redDiamonds = 0
var goldCoins = 0

func playerDamage(value):
	print("Player Hit " + str(value))

func addRedDiamond():
	redDiamonds += 1
	
func removeRedDiamond():
	redDiamonds -= 1

func addGoldCoin():
	goldCoins += 1
	
func removeGoldCoin():
	goldCoins -= 1
