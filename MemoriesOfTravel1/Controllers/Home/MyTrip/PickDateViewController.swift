//
//  RegisterDateViewController.swift
//  MemoriesOfTravel1
//
//  Created by 이하연 on 2021/10/09.
//

import UIKit
import FSCalendar

class PickDateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendar()
    }
    
    let registerTripInfo: TripInformation = TripInformation.shared
    var registerTripData: String = ""
        
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet weak var firstDateLabel: UILabel!
    @IBOutlet weak var lastDateLabel: UILabel!
    
    var firstDate: Date?
    var lastDate: Date?
    var datesRange: [Date]?
    
    let highlightedColorForRange = UIColor.init(cgColor: #colorLiteral(red: 0.5896497369, green: 0.7362760901, blue: 0.7649900317, alpha: 1))
    
    // gregorian 양력 달력
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일"
        return formatter
    }()
    
    fileprivate let formatter2: DateFormatter = {
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "MM.dd"
        return formatter2
    }()
    
    private func setupCalendar(){
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.headerHeight = 60
        calendar.delegate = self
        calendar.dataSource = self
        calendar.scrollDirection = .vertical
        calendar.pagingEnabled = false
        calendar.register(CalendarCell.self, forCellReuseIdentifier: "cell")
        calendar.allowsMultipleSelection = true
        //        calendar.layer.cornerRadius = 0
    }

    @IBAction func cancle(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectDate(_ sender: UIButton){
        let day = Int(firstDate!-Date())/(24*60*60)
        registerTripData = formatter2.string(from: firstDate!) + "-" + formatter2.string(from: lastDate!)
        registerTripInfo.setTripDate(tripDate: registerTripData)
        registerTripInfo.setTripFirstDay(tripFirstDay: firstDate!)
        registerTripInfo.setTripRange(tripRange: datesRange!.count)
        registerTripInfo.setTripDday(tripDday: day + 1)
        dismiss(animated: true, completion: nil)
    }
    
}

class calendarView: UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set(newValue) {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
            self.layer.maskedCorners = [.layerMaxXMinYCorner]
        } get {
            return self.layer.cornerRadius
        }
    }
}

extension PickDateViewController {
    func configureVisibleCells() {
        print("안녕하세요",self.calendar.visibleCells())
        self.calendar.visibleCells().forEach { (cell) in
            let date = self.calendar.date(for: cell)
            let position = self.calendar.monthPosition(for: cell)
            self.configureCell(cell, for: date, at: position)
        }
    }
    
    func configureCell(_ cell: FSCalendarCell?, for date: Date?, at position: FSCalendarMonthPosition) {
        let diyCell = (cell as! CalendarCell)
        // Configure selection layer : 선택 레이어 구성
        if position == .current {
            var selectionType = SelectionType.none
            
            // 선택된 날짜들 중에 오늘날짜가 포함되어있다면
            if calendar.selectedDates.contains(date!) {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date!)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date!)!
                if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
                    diyCell.selectionLayer.fillColor = highlightedColorForRange.cgColor
                    selectionType = .middle
                }
                else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date!) {
                    selectionType = .single // .rightBorder
                }
                else if calendar.selectedDates.contains(nextDate) {
                    selectionType = .single // .leftBorder
                }
                else {
                    selectionType = .middle //.single
                }
                
            }
            else {
                selectionType = .none
            }
            if selectionType == .none {
                diyCell.selectionLayer.isHidden = true
                return
            }
            diyCell.selectionLayer.isHidden = false
            diyCell.selectionType = selectionType
            
        }
        // cell을 표시안하고 숨기기
        else {
            diyCell.selectionLayer.isHidden = true
        }
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        // "from" 날짜가 "to" 날짜보다 긴 경우 빈 배열을 반환
        if from > to { return [Date]() }
        
        // 그게 아닐 경우 array에 추가하기
        var tempDate = from
        var array = [tempDate]
        while tempDate < to {
            // 하루 더하기
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        return array
    }
}

extension PickDateViewController:FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance {
    
    // cell을 선택했을때 호출되네
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // 처음 셀을 선택했을 경우
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]
            configureVisibleCells()
            firstDateLabel.text = "여행 시작일이 "+formatter.string(from: firstDate!)
            lastDateLabel.text = "마지막일은 ..."
            return
        }
        
        // 처음날짜와 마지막날짜를 선택했을 경우
        if firstDate != nil && lastDate == nil {
            // 마지막 날짜가 첫 번째 날짜보다 작은 경우
            // 기존에 있던 처음날짜를 제거한 후 마지막에 선택된 날짜가 다시 처음날짜가 됨
            if date <= firstDate! {
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                configureVisibleCells()
                firstDateLabel.text = "여행 시작일이 "+formatter.string(from: firstDate!)
                lastDateLabel.text = "마지막일은 ..."
                return
            }
            
            // 정상적으로 선택했을 경우
            // datesRange를 실행 (처음날짜부터 마지막날짜까지 모두 넣기)
            let range = datesRange(from: firstDate!, to: date)
            for selectCell in range {
                calendar.select(selectCell)
            }
            lastDate = range.last
            datesRange = range
            firstDateLabel.text = "여행 시작일이 "+formatter.string(from: range.first!)+"이고"
            lastDateLabel.text = "마지막일 "+formatter.string(from: range.last!)+"이 맞나요?"
            configureVisibleCells()
            return
        }
        
        // 처음날짜, 마지막날짜를 모두 선택하지 않았을 경우 -> 초기화
        if firstDate != nil && lastDate != nil {
            for cancleCell in calendar.selectedDates {
                calendar.deselect(cancleCell)
            }
            firstDate = nil
            lastDate = nil
            firstDateLabel.text = "여행 시작일과"
            lastDateLabel.text = "마지막일을 선택해주세요"
            datesRange = []
        }
        configureVisibleCells()
    }
    
    //  현재 페이지가 변환될때 호출됨
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
    }
    
    // 지정된 재사용 식별자에 대한 재사용 가능한 캘린더 뷰 셀 객체를 반환하고, 이를 캘린더에 추가
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
        
    }
    
    // 달력을 표시할때 셀도 같이 표시되게끔
    // 지정된 셀이 달력에 표시될 것임을 대리인에게 알립니다.
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.configureCell(cell, for: date, at: monthPosition)
        
    }
    
    // 셀을 눌러 특정 날짜를 선택할 수 있는지 대리인에게 묻습니다.
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == FSCalendarMonthPosition.current
    }
    
    // 이미 선택된 셀이기때문에 선택할수없다?
    // 번역 : shouldDeselect는 선택을 취소해야 합니다로 번역되는데..
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return false
    }
    
    // 대리인에게 캘린더의 날짜를 탭하여 선택 해제했음을 알립니다.
    // 작동안함
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did deselect date \(self.formatter.string(from: date))")
        configureVisibleCells()
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //Remove timeStamp from date
        if date.removeTimeStamp!.compare(Date().removeTimeStamp!) == .orderedAscending {
            return UIColor.lightGray
        }else if date.removeTimeStamp!.compare(Date().removeTimeStamp!) == .orderedDescending{
            return .black
        } else {
            return .systemPink
        }
    }
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
        switch formatter.string(from: date) {
        case formatter.string(from: Date()):
            return "⭐️"
        default:
            return nil
        }
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        
        switch formatter.string(from: date) {
        case formatter.string(from: Date()):
            return "오늘"
        default:
            return nil
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleDefaultColorFor date: Date) -> UIColor? {
        if formatter.string(from: date) == formatter.string(from: Date()) {
            return .systemPink
        }
        return nil
    }
    // fillSelectionColorFor -> 이건 셀 색깔
    
}
extension Date {
    public var removeTimeStamp : Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            return nil
        }
        return date
    }
}

