Feature: Config Demo

  Background:
    * def employeeName = 'Maggie Manning'
    * def userName = 'new_admin_test'
    * call read('UserAccess.feature@Login')

  Scenario: Login into OrangeHRM website and add new user under Admin section
    * match driver.title == 'OrangeHRM'
    And click("//a[@class='oxd-main-menu-item']//span[text()='Admin']")
    And waitForText("//div[@class='oxd-topbar-header-title']//h6", 'Admin')
    And click("//button[text()=' Add ']")
    And waitForText("//div[@class='orangehrm-card-container']//h6", 'Add User')
    * mouse("//label[text()='User Role']/../..//div[@class='oxd-select-text--after']").click()
    * mouse("//div[@role='listbox']/div/span[text()='Admin']").click()
    * mouse("//label[text()='Status']/../..//div[@class='oxd-select-text--after']").click()
    * mouse("//div[@role='listbox']/div/span[text()='Enabled']").click()
    And input("//label[text()='Employee Name']/../..//input",employeeName)
    * mouse("//div[@role='listbox']/div/span").click()
    And input("//label[text()='Username']/../..//input",userName)
    And input("//label[text()='Password']/../..//input",'newadmin123')
    And input("//label[text()='Confirm Password']/../..//input",'newadmin123')
    And click("//button[text()=' Save ']")
    And waitForText("//div[@class='oxd-table-filter-header']//h5",'System User')
    * call read('UserAccess.feature@LogOut')


  Scenario: Search newly created user validate username and then delete it
    And click("//a[@class='oxd-main-menu-item']//span[text()='Admin']")
    And waitForText("//div[@class='oxd-topbar-header-title']//h6", 'Admin')
    When input("//label[text()='Username']/../..//input",'new_admin_test')
    And click("//button[text()=' Search ']")
    Then match text("//div[@class='oxd-table-body']/div/div/div[2]/div") == 'new_admin_test'
    And click("//div[@class='oxd-table-body']/div/div/div[last()]//button[1]")
    And waitForText("//div[@role='document']/div/p",'Are you Sure?')
    And click("//div[@role='document']/div[last()]//button[2]")
    * def noRecordFoundText = exists("//span[text()='No Records Found']")
    Then if (noRecordFoundText) karate.fail('No Record Found text is not visible')
    * call read('UserAccess.feature@LogOut')