//
//  ViewController.m
//  List
//
//  Created by Nicholas Fung on 2017-09-21.
//  Copyright © 2017 Nicholas Fung. All rights reserved.
//

#import "ViewController.h"
#import "ListTableViewCell.h"
#import "AddItemViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, AddItemViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray* todos;

@property (weak, nonatomic) IBOutlet UITableView *tableVeiw;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.todos = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todos.count;
    // Set number of rows to the number of items in the todo list array
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = @"ListTableViewCell";
    ListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString* todoText = self.todos[indexPath.row];
    cell.titleLabel.text = todoText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Hello I was touched: %@", indexPath);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController* nav = segue.destinationViewController;
    AddItemViewController* addVC = nav.viewControllers[0];
    addVC.delegate = self;
}

- (void)didSaveNewTodo:(NSString *)todoText {
    [self.todos addObject:todoText];
    [self.tableVeiw reloadData];
}

-(void)tableView: (UITableView*) tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.todos removeObjectAtIndex:indexPath.row];
        [self.tableVeiw reloadData];
    }
}


@end
