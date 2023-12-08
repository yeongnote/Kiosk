//
//  main.swift
//  KioskProgramming
//
//  Created by YeongHo Ha on 12/6/23.
//

import Foundation


enum MainMenu: Int {
    //burger 케이스에 1을 명시적으로 할당하면 나머지 다른 케이스는 자동으로 값이 1씩 증가되어 할당됨.
    //이것을 열거형의 rawValue을 갖는다 라고 할 수 있는데, 이것으로 케이스를 식별할 수도 있다.
    case burger = 1
    case frozenCustard
    case drink
    case exit = 0
    
    // 메인메뉴 항목 표시
    func displayMenu() {
        switch self {
        case .burger:
            print("1. 햄버거 | 앵거스 비프 통살을 다져만든 버거")
        case .frozenCustard:
            print("2. 프로즌 커스터드 | 매장에서 신선하게 만드는 아이스크림")
        case .drink:
            print("3. 음료수 | 매장에서 직접 만드는 음료")
        case .exit:
            print("0. 종료")
        }
    }
}


struct MenuInfo {
    var name: String
    var price: Double
    var description: String
}

//버거 항목
var burger = [
    MenuInfo(name: "쉑버거", price: 6.9, description: "토마토, 양상추, 쉑소스가 토핑된 치즈버거"),
    MenuInfo(name: "스모크쉑", price: 8.9, description: "베이컨, 체리 페퍼에 쉑소스가 토핑된 치즈버거"),
    MenuInfo(name: "슈룸버거", price: 9.4, description: "몬스터 치즈와 체다 치즈로 속을 채운 베지테리안 버거"),
    MenuInfo(name: "치즈버거", price: 6.9, description: "포테이토 번과 비프패티, 치즈가 토핑된 치즈버거"),
    MenuInfo(name: "햄버거", price: 5.4, description: "비프패티를 기반으로 야채가 들어간 기본버거")
]
//커스타드 항목
var frozenCustard = [
    MenuInfo(name: "쉐이크", price: 5.9, description: "바닐라, 초콜렛, 솔티드 카라멜, 블랙&화이트"),
    MenuInfo(name: "플로트", price: 5.9, description: "루트 비어, 퍼플 카우, 크림시클"),
    MenuInfo(name: "컵_콘", price: 4.9, description: "바닐라, 초콜렛, Flovor of the Week")
]

//음료수 항목
var drink = [
    MenuInfo(name: "레몬에이드", price: 3.9, description: "매장에서 직접 만드는 상큼한 레몬에이드"),
    MenuInfo(name: "아이스티", price: 3.4, description: "직접 유기농 홍차를 우려낸 아이스티"),
    MenuInfo(name: "피프티", price: 3.5, description: "레몬에이드와 아이스티의 만남"),
    MenuInfo(name: "탄산음료", price: 2.7, description: "코카콜라, 코카콜라 제로, 스프라이트, 환타"),
    MenuInfo(name: "무알콜맥주", price: 4.4, description: "청량감 있는 독특한 미국식 무알콜 탄산음료")
]

//상세 메뉴
func displaySubMenu(menuItems: [MenuInfo]) {
    //menuItems 배열을 받아와서 각 항목을 출력
    for (index, item) in menuItems.enumerated() {
        
        print("\(index + 1). \(item.name) | 가격: \(item.price) | \(item.description)")
    }
    print("0. 이전으로 돌아가기")
}


var mainMenuSelected = false

while true {
    
    //메인 화면에 출력될 메뉴
    if !mainMenuSelected {
        print("[ SHAKESHACK MENU ]")
        MainMenu.burger.displayMenu()
        MainMenu.frozenCustard.displayMenu()
        MainMenu.drink.displayMenu()
        MainMenu.exit.displayMenu()
    }
    
    
    if let input = readLine(),
       let selection = Int(input),
       let menu = MainMenu(rawValue: selection) {
        switch menu {
        case .burger, .frozenCustard, .drink:
            mainMenuSelected = true
            let selectedSubMenu = menuItems(for: menu)
            displaySubMenu(menuItems: selectedSubMenu)
            if let additionalOrder = askForAdditionalOrder() {
                print("추가 주문: \(additionalOrder)")
            } else {
                print("결제를 진행합니다.")
                    exit(0)
            }
        case .exit:
            print("프로그램을 종료합니다.")
            exit(0)
        }
    } else {
        print("잘못 선택했습니다.")
    }
    
    mainMenuSelected = false
}

func menuItems(for menu: MainMenu) -> [MenuInfo] {
    switch menu {
    case .burger:
        return burger
    case .frozenCustard:
        return frozenCustard
    case .drink:
        return drink
    case .exit:
        return []
    }
}

// 추가 주문 여부를 묻고 사용자의 선택을 반환
func askForAdditionalOrder() -> String? {
    print("추가 주문하시겠습니까? (yes/no): ", terminator: "")
    if let response = readLine()?.lowercased() {
        if response == "yes" {
            print("추가 주문 받습니다.")
            print("새로운 주문을 입력하세요.", terminator: "")
            return readLine()
        } else if response == "no" {
            return nil
        }
    }
    print("잘못 선택했습니다.")
    return askForAdditionalOrder()
}









//레거시 코드
/*
//각 메뉴 항목.
var burgers = [
    "1. 쉑버거 | W 6.9 | 토마토, 양상추, 쉑소스가 토핑된 치즈버거",
    "2. 스모크쉑 | W 8.9 | 베이컨, 체리 페퍼에 쉑소스가 토핑된 치즈버거",
    "3. 슈룸버거 | W 9.4 | 몬스터 치즈와 체다 치즈로 속을 채운 베지테리안 버거",
    "4. 치즈버거 | W 6.9 | 포테이토 번과 비프패티, 치즈가 토핑된 치즈버거",
    "5. 햄버거 | W 5.4 | 비프패티를 기반으로 야채가 들어간 기본버거"
]
var frozenCustards = [
    "쉐이크 | W 5,9 | 바닐라, 초콜렛, 솔티드 카라멜, 블랙&화이트",
    "플로트 | W 5,9 | 루트 비어, 퍼플 카우, 크림시클",
    "컵_콘 | W 4,9 | 바닐라, 초콜렛, Flovor of the Week"
]
var drinks = [
    "레몬에이드 | W3,9 | 매장에서 직접 만드는 상큼한 레몬에이드",
    "아이스티 | W 3,4 | 직접 유기농 홍차를 우려낸 아이스티",
    "피프티 | W 3,5 | 레몬에이드와 아이스티의 만남",
    "탄산음료 | W 2,7 | 코카콜라, 코카콜라 제로, 스프라이트, 환타",
    "무알콜맥주 | W 4,4 | 청량감 있는 독특한 미국식 무알콜 탄산음료"
]
*/
