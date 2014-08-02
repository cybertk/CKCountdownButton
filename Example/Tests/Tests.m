//
//  CKCountdownButtonTests.m
//  CKCountdownButtonTests
//
//  Created by Quanlong He on 08/02/2014.
//  Copyright (c) 2014 Quanlong He. All rights reserved.
//


SpecBegin(InitialSpecs)

describe(@"Create a new CKCountdownButton", ^{

    it(@"should in 'normal' state", ^{

        CKCountdownButton *button = [[CKCountdownButton alloc] init];
        expect(button.state).equal(UIControlStateNormal);
    });
});

describe(@"Set 'count' to a CKCountdownButton", ^{

    describe(@"and does not set 'Title'", ^{
        it(@"should have 'count' set", ^{

            CKCountdownButton *button = [[CKCountdownButton alloc] init];
            button.count = 10;

            expect(button.count).equal(10);
        });

        it(@"should in 'disabled' state", ^{

            CKCountdownButton *button = [[CKCountdownButton alloc] init];
            button.count = 10;

            expect(button.state).equal(UIControlStateDisabled);
        });

        it(@"should set 'Title' to 'Count'", ^{
            CKCountdownButton *button = [[CKCountdownButton alloc] init];
            button.count = 10;

            expect(button.titleLabel.text).equal(@"10");
        });

        it(@"should start counting down", ^{

            CKCountdownButton *button = [[CKCountdownButton alloc] init];
            button.count = 3;

            expect(button.titleLabel.text).to.equal(@"3");
            expect(button.titleLabel.text).after(1).to.equal(@"2");
            expect(button.titleLabel.text).after(2).to.equal(@"1");
        });

        it(@"should in 'normal' state after counted down", ^{

            CKCountdownButton *button = [[CKCountdownButton alloc] init];
            button.count = 1;

            expect(button.state).after(1).to.equal(UIControlStateNormal);
        });

        it(@"should display normal 'Title' after counted down", ^{

            CKCountdownButton *button = [[CKCountdownButton alloc] init];
            button.count = 1;

            expect(button.titleLabel.text).after(2).to.equal(@"");

            button = [[CKCountdownButton alloc] init];
            [button setTitle:@"Title" forState:UIControlStateNormal];
            button.count = 1;

            expect(button.titleLabel.text).after(1).to.equal(@"Title");
        });
    });
});

describe(@"these will pass", ^{
    
    it(@"can do maths", ^{
        expect(1).beLessThan(23);
    });
    
    it(@"can read", ^{
        expect(@"team").toNot.contain(@"I");
    });
    
    it(@"will wait and succeed", ^AsyncBlock {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            done();
        });
    });
});

SpecEnd
