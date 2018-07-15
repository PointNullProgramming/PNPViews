//
//  File.swift
//  
//
//  Created by Ethan Hardacre on 7/14/18.
//


/**
 A sexy curved meny written in swift
 Holds four menu items
 */
public class CurveMenu : UIView {
    
    //colors!
    var color        : UIColor = UIColor()
    var buttonColor  : UIColor = UIColor()
    var buttonColor2 : UIColor = UIColor()
    
    //is the menu open? ask to find out
    var menuOpen = false
    
    //it dims the view ... like it says
    var dimmingView = UIButton()
    var dimAlpha : CGFloat = 0.5
    
    //the view that the menu is placed on
    var mock = UIView()
    //toggles the open menu
    var button             = UIButton()
    var buttonImageView    = UIImageView()
    var buttonImage        = UIImage()
    var buttonImage2       = UIImage()
    
    //all the dims; I forget what all them do
    var view_width             : CGFloat = 0,
    view_height            : CGFloat = 0,
    menu_vertical_buffer   : CGFloat = 0,
    menu_width             : CGFloat = 0,
    menu_height            : CGFloat = 0,
    button_vertical_buffer : CGFloat = 0,
    button_width           : CGFloat = 0,
    tab_section_buffer     : CGFloat = 0,
    tab_size               : CGFloat = 0,
    tab_vertical_buffer    : CGFloat = 0,
    tab_horizontal_buffer  : CGFloat = 0
    //the magic number
    var pi = CGFloat(Double.pi)
    
    //the menu options
    var num_tabs  : CGFloat      = 0
    var labels    : [String]     = []
    var textColor : UIColor      = UIColor()
    var functions : [() -> Void] = []
    var icons     : [UIImage]    = []
    
    /**
     A menu that has a changing button color and controlled dimming view alpha
     */
    required public init(view: UIView, dimAlpha: CGFloat, buttonImage : UIImage, buttonImage2 : UIImage,
                  color: UIColor, buttonColor: UIColor, buttonColor2: UIColor, //colors
        labels: [String], icons: [UIImage], functions: [() -> Void], textColor : UIColor) // tabs
    { //wow, that is a lot of parameters ...
        super.init(frame: view.frame)
        
        //...lets use them
        self.mock           = view
        self.dimAlpha       = dimAlpha
        self.buttonImage    = buttonImage
        self.buttonImage2   = buttonImage2
        self.color          = color
        self.buttonColor    = buttonColor
        self.buttonColor2   = buttonColor2
        self.labels         = labels
        self.num_tabs       = CGFloat(labels.count)
        self.icons          = icons
        self.functions      = functions
        self.textColor      = textColor
        
        setUp()
    }
    
    /**
     Just a basic menu with changing icons on the button
     */
    required public init(view: UIView, buttonImage : UIImage, buttonImage2 : UIImage,
                  color: UIColor, buttonColor: UIColor, //colors
        labels: [String], icons: [UIImage], functions: [() -> Void], textColor : UIColor) // tabs
    { //wow, that is a lot of parameters ...
        super.init(frame: view.frame)
        
        //...lets use them
        self.mock           = view
        self.buttonImage    = buttonImage
        self.buttonImage2   = buttonImage2
        self.color          = color
        self.buttonColor    = buttonColor
        self.buttonColor2   = buttonColor
        self.labels         = labels
        self.num_tabs       = CGFloat(labels.count)
        self.icons          = icons
        self.functions      = functions
        self.textColor      = textColor
        
        setUp()
    }
    
    /*
     Required initializer only called at access from .nib files
     */
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     checks the validity of the parameters passed in init
     */
    private func checkValidity(){
        assert(num_tabs == 4,
               "There must be 4 labels provided for the Curved Menu")
        assert(functions.count == Int(num_tabs),
               "There must be a function provided for each tab in the Curved Menu")
        assert(icons.count == Int(num_tabs),
               "There must be an icon provided for each tab in the Curved Menu")
    }
    
    /*
     does the set up that doesn't need to be in the initializer
     */
    private func setUp(){
        init_dims()
        init_menu()
        init_button()
        init_tabs()
    }
    
    /*
     Initializes the dimensions of the views
     */
    private func init_dims(){
        //setting up the dimentions for the whole menu
        view_width = mock.frame.width
        view_height = mock.frame.height
        menu_vertical_buffer = CGFloat(floor(Double(view_height/17.5)))
        menu_width = CGFloat(floor(Double(view_width/2.67)))
        button_vertical_buffer = CGFloat(floor(Double(menu_vertical_buffer/3.6)))
        button_width = menu_width - CGFloat(floor(Double(menu_width/7)))
        menu_height = mock.frame.height - 2*(menu_vertical_buffer)
        
        //setting up the dimensions for the tabs
        tab_section_buffer = menu_vertical_buffer * 2
        tab_horizontal_buffer = menu_width/4
        tab_size = menu_width - 2 * (tab_horizontal_buffer)
        tab_vertical_buffer = (menu_height - (4*menu_vertical_buffer) - (tab_size * num_tabs))/num_tabs + 10
        tab_vertical_buffer = CGFloat(floor(Double(tab_vertical_buffer)))
    }
    
    /*
     Initializes the menu view
     */
    private func init_menu(){
        self.frame = CGRect(x: mock.frame.width,
                            y: menu_vertical_buffer,
                            width: menu_width,
                            height: menu_height)
        backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        dimmingView = UIButton(frame: CGRect(x: 0, y: 0, width: mock.frame.width, height: mock.frame.height))
        dimmingView.addTarget(self, action: #selector(changeMenuState), for: .touchUpInside)
    }
    
    /*s
     Initializes the tabs
     */
    private func init_tabs(){
        var pos = tab_section_buffer
        //set up each tab
        for i in 1...Int(num_tabs){
            //this is the tab,
            let tab = UIButton(frame: CGRect(x: tab_horizontal_buffer,
                                             y: pos, width: tab_size, height: tab_size))
            //and here is the label,
            let label = UILabel(frame: CGRect(x: tab_horizontal_buffer - 2.5, y: pos + tab_size - 15, width: tab_size + 5, height: tab_vertical_buffer - 4))
            label.text = labels[i - 1]
            label.textColor =  textColor
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 13)
            
            pos = pos + tab_size + tab_vertical_buffer
            tab.layer.cornerRadius = tab_size/2
            tab.backgroundColor = color
            let image = UIImageView(frame: CGRect(x: 10, y: 10, width: tab_size - 20, height: tab_size - 20))
            image.image = icons[i - 1]
            //lets add a switch,
            switch i{
            //to make each button able.
            case 1:
                tab.addTarget(self, action: #selector(function1), for: .touchUpInside)
            case 2:
                tab.addTarget(self, action: #selector(function2), for: .touchUpInside)
            case 3:
                tab.addTarget(self, action: #selector(function3), for: .touchUpInside)
            case 4:
                tab.addTarget(self, action: #selector(function4), for: .touchUpInside)
            default:
                return
            }
            
            tab.addSubview(image)
            
            self.addSubview(tab)
            self.addSubview(label)
            
        }
    }
    
    //These are the functions that communicate between the tab buttons and the specified functions
    @objc private func function1(){ self.changeMenuState(); functions[0]() }
    @objc private func function2(){ self.changeMenuState(); functions[1]() }
    @objc private func function3(){ self.changeMenuState(); functions[2]() }
    @objc private func function4(){ self.changeMenuState(); functions[3]() }
    
    /*
     Initializes the button that opens the menu
     */
    private func init_button(){
        button = UIButton(frame: CGRect(x: mock.frame.width - menu_width,
                                        y: mock.frame.height - (menu_vertical_buffer + (2 * button_vertical_buffer)),
                                        width: button_width,
                                        height: menu_vertical_buffer))
        button.backgroundColor =  buttonColor
        button.layer.cornerRadius = button.frame.height/2
        button.addTarget(self, action: #selector(changeMenuState), for: .touchUpInside)
        buttonImageView = UIImageView(frame: CGRect(x: button.frame.width/2 - 15, y: button.frame.height/2 - 15, width: 30, height: 30))
        buttonImageView.image =  buttonImage
        buttonImageView.contentMode = .scaleAspectFit
        button.addSubview(buttonImageView)
        mock.addSubview(button)
    }
    /*
     Returns the Frame of the button that toggles the menu
     Question: Why did I include this?
     Answer:
     */
    private func getButtonDims() -> CGRect {
        return CGRect(x: mock.frame.width - menu_width, y: mock.frame.height - (menu_vertical_buffer + (2 * button_vertical_buffer)), width: button_width, height: menu_vertical_buffer)
    }
    
    /*
     Target of the button/
     Actions that occur upon opening the menu
     */
    @objc private func changeMenuState(){
        //close the menu
        if menuOpen {
            UIView.animate(withDuration: 0.1, animations: {
                self.frame = CGRect(x: self.mock.frame.width,
                                    y: self.menu_vertical_buffer,
                                    width: self.menu_width,
                                    height: self.mock.frame.height - 2*(self.menu_vertical_buffer))
                self.dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
                self.button.backgroundColor =  self.buttonColor
                self.buttonImageView.image =  self.buttonImage
            })
            dimmingView.removeFromSuperview()
            self.menuOpen = false
            //open the menu
        }else{
            mock.addSubview(dimmingView)
            UIView.animate(withDuration: 0.1, animations: {
                self.frame = CGRect(x: self.mock.frame.width - self.menu_width,
                                    y: self.menu_vertical_buffer,
                                    width: self.menu_width,
                                    height: self.mock.frame.height - 2*(self.menu_vertical_buffer))
                self.dimmingView.backgroundColor =  UIColor.black.withAlphaComponent(self.dimAlpha)
                self.button.backgroundColor =  self.buttonColor2
                self.buttonImageView.image = self.buttonImage2
            })
            self.menuOpen = true
            mock.bringSubview(toFront: self)
            mock.bringSubview(toFront: button)
        }
    }
    
    /*
     remove from superview also removes the menu button from the mock
     */
    override public func removeFromSuperview() {
        button.removeFromSuperview()
        super.removeFromSuperview()
    }
    
    /*
     redraw the menu for fancy curves
     */
    override public func draw(_ rect: CGRect) {
        let BR = CGPoint(x: frame.width,
                         y: frame.height)
        let TR = CGPoint(x: frame.width,
                         y: 0.0)
        let anchorOne = CGPoint(x: BR.x - menu_vertical_buffer,
                                y: BR.y)
        let anchorTwo = CGPoint(x: 0.0 + menu_vertical_buffer,
                                y: BR.y - (2*menu_vertical_buffer))
        let anchorThree = CGPoint(x: 0.0 + menu_vertical_buffer ,
                                  y: 0.0 + (2*menu_vertical_buffer))
        let anchorFour = CGPoint(x: TR.x - menu_vertical_buffer,
                                 y: 0.0)
        
        let path = UIBezierPath()
        path.move(to: BR)
        path.addArc(withCenter: anchorOne,
                    radius: menu_vertical_buffer,
                    startAngle: 0,
                    endAngle: 3*pi/2,
                    clockwise: false)
        path.addLine(to: CGPoint(x: anchorTwo.x,
                                 y: anchorTwo.y + 38))
        path.addArc(withCenter: anchorTwo,
                    radius: menu_vertical_buffer,
                    startAngle: 3*pi/2,
                    endAngle: pi,
                    clockwise: true)
        path.addLine(to: CGPoint(x: 0.0,
                                 y: anchorThree.y))
        path.addArc(withCenter: anchorThree,
                    radius: menu_vertical_buffer,
                    startAngle: pi,
                    endAngle: 3*pi/2,
                    clockwise: true)
        path.addLine(to: CGPoint(x: anchorFour.x,
                                 y: anchorFour.y + menu_vertical_buffer))
        path.addArc(withCenter: anchorFour,
                    radius: menu_vertical_buffer,
                    startAngle: pi/2,
                    endAngle: 0.0,
                    clockwise: false)
        path.close()
        color.setFill()
        path.fill()
    }
    
    
}

