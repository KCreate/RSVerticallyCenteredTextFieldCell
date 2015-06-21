//
//  RSVerticallyCenteredTextField.swift
//  RSCommon
//
//  Originally created by Daniel Jalkut on 6/17/06.
//  Copyright 2006 Red Sweater Software. All rights reserved.
//
//  Rewritten in Swift by Leonard Schuetz on 21.06.15
//  Twitter: leni4838
//  Web: leonardschuetz.ch


import Foundation
import Cocoa

class RSVerticallyCenteredTextFieldCell: NSTextFieldCell {
    var mIsEditingOrSelecting:Bool = false
    
    override func drawingRectForBounds(theRect: NSRect) -> NSRect {
        //Get the parent's idea of where we should draw
        var newRect:NSRect = super.drawingRectForBounds(theRect)
        
        // When the text field is being edited or selected, we have to turn off the magic because it screws up
        // the configuration of the field editor.  We sneak around this by intercepting selectWithFrame and editWithFrame and sneaking a
        // reduced, centered rect in at the last minute.
        
        if !mIsEditingOrSelecting {
            // Get our ideal size for current text
            let textSize:NSSize = self.cellSizeForBounds(theRect)
            
            //Center in the proposed rect
            let heightDelta:CGFloat = newRect.size.height - textSize.height
            if heightDelta > 0 {
                newRect.size.height -= heightDelta
                newRect.origin.y += heightDelta/2
            }
        }
        
        return newRect
    }
    
    override func selectWithFrame(var aRect: NSRect, inView controlView: NSView, editor textObj: NSText, delegate anObject: AnyObject?, start selStart: Int, length selLength: Int) {
        aRect = self.drawingRectForBounds(aRect)
        mIsEditingOrSelecting = true;
        super.selectWithFrame(aRect, inView: controlView, editor: textObj, delegate: anObject, start: selStart, length: selLength)
        mIsEditingOrSelecting = false;
    }
    
    override func editWithFrame(var aRect: NSRect, inView controlView: NSView, editor textObj: NSText, delegate anObject: AnyObject?, event theEvent: NSEvent) {
        aRect = self.drawingRectForBounds(aRect)
        mIsEditingOrSelecting = true;
        super.editWithFrame(aRect, inView: controlView, editor: textObj, delegate: anObject, event: theEvent)
        mIsEditingOrSelecting = false
    }
}