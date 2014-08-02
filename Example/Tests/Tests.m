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

        it(@"should display title as 'Count'", ^{
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

        it(@"should display 'empty' title after counted down", ^{

            CKCountdownButton *button = [[CKCountdownButton alloc] init];
            button.count = 1;

            expect(button.titleLabel.text).after(2).to.equal(@"");
        });
    });

    describe(@"and set 'Disabled Title'", ^{

        it(@"should display normal 'Title' after counted down", ^{

            CKCountdownButton *button = [[CKCountdownButton alloc] init];
            [button setTitle:@"Title" forState:UIControlStateNormal];
            button.count = 1;

            expect(button.titleLabel.text).after(1).to.equal(@"Title");
        });

        describe(@"and does not contain 'Placeholder", ^{

            it(@"should display count as title", ^{
                CKCountdownButton *button = [[CKCountdownButton alloc] init];
                [button setTitle:@"Title" forState:UIControlStateDisabled];
                button.count = 1;

                expect(button.titleLabel.text).to.equal(@"1");
            });
        });

        describe(@"and contains 'Placeholder", ^{

            it(@"should display count embedded in title", ^{
                CKCountdownButton *button = [[CKCountdownButton alloc] init];
                [button setTitle:@"Title (#)" forState:UIControlStateDisabled];
                button.count = 1;

                expect(button.titleLabel.text).to.equal(@"Title (1)");
            });
        });
    });
});

describe(@"Reuse exist CKCountdownButton", ^{

    __block CKCountdownButton *button;

    beforeAll(^{
        button = [[CKCountdownButton alloc] init];
    });

    it(@"cannot modify count while counting ", ^{
        button.count = 1;
        button.count = 2;

        expect(button.count).equal(1);
        expect(button.count).after(2).to.equal(1);
    });

    it(@"can modify count after counted down ", ^AsyncBlock {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            button.count = 3;
            done();
        });

        expect(button.count).after(2).to.equal(3);
        expect(button.titleLabel.text).after(3).to.equal(@"2");
        expect(button.titleLabel.text).after(4).to.equal(@"1");

        expect(button.titleLabel.text).after(5).to.equal(@"");
    });
});

describe(@"Delegation", ^{
    describe(@"when counted down", ^{

        it(@"should invoke delegation", ^{
            CKCountdownButton *button = [[CKCountdownButton alloc] init];;

            // In a test
            id mock = [OCMockObject mockForProtocol:@protocol(CKCountdownButtonDelegate)];

            [[mock expect] countedDown:button];

            button.count = 1;
            button.delegate = mock;

            [mock verifyWithDelay:1.0];
        });
    });
});

SpecEnd
