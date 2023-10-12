Feature: User Login and Logout scenarios

  Background:
    * configure driver = {type: 'chrome', executable: 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe', addOptions: ["--remote-allow-origins=*"] };
    Given driver 'https://opensource-demo.orangehrmlive.com/web/index.php/auth/login'
    And driver.maximize()

  @Login
  Scenario: Login into the application
    When input('input[name=username]','admin')
    And input('input[name=password]','admin123')
    And click("//button[@type='submit']")
    Then waitForText("//div[@class='oxd-topbar-header-title']//h6", 'Dashboard')

  @LogOut
  Scenario: LogOut from application
    When mouse("//li[@class='oxd-userdropdown']").click()
    And click("//ul[@class='oxd-dropdown-menu']/li[last()]/a")
    And waitForText("//div[@class='orangehrm-login-slot']//h5",'Login')
    * def inputBox = exists('input[name=username]')
    Then if (inputBox == false) karate.fail('User name box not visible')