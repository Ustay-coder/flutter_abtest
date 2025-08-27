
/// UI AB Testing tool을 위한 클래스입니다. 
/// 이 라이브러리를 사용하면, 특정 화면에서 UI가 랜덤한 비율로 나옵니다. 
/// 
/// Class for UI AB Testing tool.
/// Using this library, UI appears with random ratios on specific screens.

import 'package:flutter/material.dart';
import 'dart:math';

class ABTestManager {
  
  /// test는 다음과 같은 형식으로 구현됨
  /// ABTestManager.test(ABTestUnit(UI A, 0.5), ABTestUnit(UI B, 0.5), ABTestUnit()....);
  /// 이렇게 하면, UI A 와 UI B 가 각각 50% 의 확률로 랜덤하게 나옵니다. 
  /// 이 라이브러리는 특정 화면에서만 사용되어야 합니다. 
  /// 
  /// Test is implemented in the following format:
  /// ABTestManager.test(ABTestUnit(UI A, 0.5), ABTestUnit(UI B, 0.5), ABTestUnit()....);
  /// This way, UI A and UI B appear randomly with 50% probability each.
  /// This library should only be used on specific screens.

  /// 여러 개의 ABTestUnit을 리스트로 받아서 처리하는 함수
  /// 사용 예시: ABTestManager.testList([unit1, unit2, unit3, ...]);
  /// 확률에 따라 선택된 Widget을 반환합니다.
  /// 
  /// Function that processes multiple ABTestUnits as a list
  /// Usage example: ABTestManager.testList([unit1, unit2, unit3, ...]);
  /// Returns the selected Widget based on probability.
  static Widget testUI(List<ABTestUnit> units) {
    if (units.isEmpty) {
      throw Exception('ABTestManager: units 리스트가 비어있습니다.');
    }
    
    // 확률에 따른 랜덤 선택 로직
    // Random selection logic based on probability
    double random = Random().nextDouble();
    double cumulativeProbability = 0.0; // 누적 확률 / Cumulative probability
    
    /// 각 unit들의 
    /// For each unit
    for (ABTestUnit unit in units) {
      cumulativeProbability += unit.probability;

      // 각 유닛들의 확률의 총합이 1이 넘으면 에러를 발생시킵니다.
      // If the sum of probabilities of each unit exceeds 1, an error is thrown.
      if (cumulativeProbability > 1) {
        throw Exception('ABTestManager: 각 유닛들의 확률의 총합이 1이 넘습니다. 확률을 다시 확인해주세요.');
      }

      if (random <= cumulativeProbability) {
        // 선택된 unit의 widget을 반환
        // Return the widget of the selected unit
        return unit.getWidget();
      }
    }
    
    // 모든 확률을 통과했지만 선택되지 않은 경우 (확률 합이 1보다 작은 경우)
    // 마지막 unit을 반환하거나 에러를 발생시킵니다.
    // If all probabilities are passed but not selected (sum of probabilities is less than 1)
    // Return the last unit or throw an error.
    if (cumulativeProbability < 1) {
      print('ABTestManager: 경고 - 확률의 총합이 1보다 작습니다. 마지막 unit을 반환합니다.');
    }
    return units.last.getWidget();
  }
}

// AB Test UI 의 단위 Unit 입니다. 
// Unit for AB Test UI.
class ABTestUnit {

  final double probability; 
  final Widget? widget; 
  final Widget Function()? widgetBuilder;

  /// Widget을 직접 받는 생성자
  /// Constructor that directly receives a Widget
  ABTestUnit.widget({required this.probability, required this.widget}) 
      : widgetBuilder = null;

  /// Widget을 생성하는 함수를 받는 생성자
  /// Constructor that receives a function that creates a Widget
  ABTestUnit.builder({required this.probability, required this.widgetBuilder}) 
      : widget = null;

  /// 기존 호환성을 위한 생성자 (Widget을 받음)
  /// Constructor for backward compatibility (receives Widget)
  ABTestUnit({required this.probability, required this.widget}) 
      : widgetBuilder = null;

  /// 선택된 Widget을 반환합니다.
  /// Returns the selected Widget.
  Widget getWidget() {
    if (widget != null) {
      return widget!;
    } else if (widgetBuilder != null) {
      return widgetBuilder!();
    } else {
      throw Exception('ABTestUnit: widget 또는 widgetBuilder가 설정되지 않았습니다.');
    }
  }
}


/// 
/// 