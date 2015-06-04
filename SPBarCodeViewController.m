//
//  SPBarCodeViewController.m
//  SmartPill
//
//  Created by Dennis da Silva Nunes on 28/02/15.
//  Copyright (c) 2015 IFRN - Mobile School. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "SPBarCodeViewController.h"

@interface SPBarCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureVideoPreviewLayer *_prevLayer;
    
    UIView *_highlightView;
    UILabel *_label;
}
@end

@implementation SPBarCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _highlightView = [[UIView alloc] init];
    _highlightView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
    _highlightView.layer.borderColor = [UIColor greenColor].CGColor;
    _highlightView.layer.borderWidth = 3;
    [self.view addSubview:_highlightView];
    
    _label = [[UILabel alloc] init];
    _label.frame = CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40);
    _label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _label.backgroundColor = [UIColor colorWithWhite:0.15 alpha:0.65];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.text = @"";
    [self.view addSubview:_label];
    
    _session = [[AVCaptureSession alloc] init];
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if (_input) {
        [_session addInput:_input];
    } else {
        NSLog(@"Error: %@", error);
    }
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:_output];
    
    _output.metadataObjectTypes = [_output availableMetadataObjectTypes];
    
    _prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _prevLayer.frame = self.view.bounds;
    _prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:_prevLayer];
    
    [_session startRunning];
    
    [self.view bringSubviewToFront:_highlightView];
    [self.view bringSubviewToFront:_label];
    [self createCancelButton];
}

- (void)createCancelButton{
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelButton addTarget:self
                             action:@selector(cancelButtonAction)
                   forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"Cancelar" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
    cancelButton.frame = CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40);
    [self.view addSubview:cancelButton];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *metadata in metadataObjects) {
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type])
            {
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[_prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        
        if (detectionString != nil)
        {
            _label.text = detectionString;
            int number = [detectionString intValue];
            NSNumber * objInt = [NSNumber numberWithInt:number];
//PEGAR REMEDIO DO SERVIDOR
            //Medicine * medicine = [self getMedicineFromServerWithNumber:objInt];
//            if (medicine) {
//                [self sendMedicineToNewMedicineVC:medicine];
//            }
            break;
        }
        else
            _label.text = @"Código não encontrado";
    }
    
    _highlightView.frame = highlightViewRect;
}
//ENVIAR REMEDIO PARA O SERVIDOR
//- (Medicine *)getMedicineFromServerWithNumber:(NSNumber*)barNumber{
//    SPConnectionRest * connection = [[SPConnectionRest alloc]init];
//    Medicine * medicine = [connection getMedicineWithCodeBarNumber:barNumber];
//    return medicine;
//}

- (void)sendMedicineToNewMedicineVC:(Medicine *)medicine{
    //self.delegate.medicine = medicine;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelButtonAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end