/*
 ******************************************************************************************
 * @file        main.c
 * @author      GowinSemiconductor
 * @device      Gowin_EMPU(GW1NS-4C)
 * @brief       Main program body.
 ******************************************************************************************
 */

/* Includes ------------------------------------------------------------------*/
#include "gw1ns4c.h"
#include "stdint.h"

/*!< The base address for the APB2 peripherals */
constexpr uint32_t apb2_periph_base = 0x40002400;
/*!< APB2 peripherals on GW1NSR-LV4C are 256 bytes */
constexpr uint32_t apb2_periph_size = 0x100;

struct APB2_leds_peripheral {
  uint32_t volatile the_led : 1;
};

APB2_leds_peripheral *leds =
    reinterpret_cast<APB2_leds_peripheral *>(apb2_periph_base);

void initialize_timer();
void delay_millis(uint32_t ms);
/**
 * @brief  Main program.
 * @param  None
 * @retval None
 */
int main(void) {
  /*!< At this stage the microcontroller clock setting is already configured,
     this is done through SystemInit() function which is called from startup
     file (startup_gw1ns4c.s) before to branch to application main.
     To reconfigure the default setting of SystemInit() function, refer to
     system_gw1ns4.c file
   */
  SystemInit();
  initialize_timer();

  /* Add your application code here */

  /* Infinite loop */
  while (1) {
    leds->the_led = 0;
    delay_millis(500);
    leds->the_led = 1;
    delay_millis(500);
  }
}

void initialize_timer() {
  TIMER_InitTypeDef timerInitStruct;

  timerInitStruct.Reload = 0;

  // Disable interrupt requests from timer for now
  timerInitStruct.TIMER_Int = DISABLE;

  // Disable timer enabling/clocking from external pins (GPIO)
  timerInitStruct.TIMER_Exti = TIMER_DISABLE;

  TIMER_Init(TIMER0, &timerInitStruct);
  TIMER_StopTimer(TIMER0);
}

#define CYCLES_PER_MILLISEC (SystemCoreClock / 1000)
void delay_millis(uint32_t ms) {
  TIMER_StopTimer(TIMER0);
  // Reset timer just in case it was modified elsewhere
  TIMER_SetValue(TIMER0, 0);
  TIMER_EnableIRQ(TIMER0);

  uint32_t reloadVal = CYCLES_PER_MILLISEC * ms;
  // Timer interrupt will trigger when it reaches the reload value
  TIMER_SetReload(TIMER0, reloadVal);

  TIMER_StartTimer(TIMER0);
  // Block execution until timer wastes the calculated amount of cycles
  while (TIMER_GetIRQStatus(TIMER0) != SET)
    ;

  TIMER_StopTimer(TIMER0);
  TIMER_ClearIRQ(TIMER0);
  TIMER_SetValue(TIMER0, 0);
}

#ifdef USE_FULL_ASSERT
/**
 * @brief  Reports the name of the source file and the source line number
 *         where the assert_param error has occurred.
 * @param  file: pointer to the source file name
 * @param  line: assert_param error line source number
 * @retval None
 */
void assert_failed(uint8_t *file, uint32_t line) {
  /* User can add his own implementation to report the file name and line
     number, ex: printf("Wrong parameters value: file %s on line %d\r\n", file,
     line) */

  /* Infinite loop */
  while (1) {
  }
}
#endif

/**
 * @}
 */
