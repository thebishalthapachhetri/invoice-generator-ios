//
//  CountryListTableViewController.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "CountryListTableViewController.h"
#import "CountryListTableViewCell.h"

@interface CountryListTableViewController (){
    NSArray *countryListArray;
}

@end

@implementation CountryListTableViewController
@synthesize delegate;
@synthesize customerDetailsArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Countries";
    countryListArray = [self getListOfCountries];
}

-(NSArray *)getListOfCountries {
    NSMutableArray *countryList = [[NSMutableArray alloc]init];
    for (id code in NSLocale.ISOCountryCodes) {
        NSString *countryID = [NSLocale localeIdentifierFromComponents:@{NSLocaleCountryCode: code}];
        NSString *name = [[NSLocale localeWithLocaleIdentifier:@"en_UK"]displayNameForKey:NSLocaleIdentifier value:countryID];
        [countryList addObject:name];
    }
    return [NSArray arrayWithArray:countryList];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    #warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    #warning Incomplete implementation, return the number of rows
    if(customerDetailsArray.count>0){
        return customerDetailsArray.count;
    }else{
        return countryListArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CountryListTableViewCell *cell = (CountryListTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"CountryListTableViewCell" forIndexPath:indexPath];
    if(customerDetailsArray.count>0){
        FIRDataSnapshot *snapshot = customerDetailsArray[indexPath.row];
        cell.textLabel.text = snapshot.value[CUSTOMER_NAME];
        cell.detailTextLabel.text = snapshot.value[CUSTOMER_EMAIL];
    }else{
        NSString *country = countryListArray[indexPath.row];
        cell.textLabel.text = country;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(customerDetailsArray.count>0){
        [delegate getValue:customerDetailsArray withIndex:indexPath.row];
    }else{
        [delegate getValue:countryListArray withIndex:indexPath.row];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
