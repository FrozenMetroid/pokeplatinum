#ifndef POKEPLATINUM_CAMERA_TRANSLATION_H
#define POKEPLATINUM_CAMERA_TRANSLATION_H

#include <nitro/fx/fx.h>

#include "camera.h"
#include "sys_task_manager.h"
#include "sys_task.h"

typedef struct CameraTranslationPathTemplate {
    u16 angle; // by the x axis
    u16 fovY;
    VecFx32 position;
    fx32 distance;
} CameraTranslationPathTemplate;

typedef struct GFCameraTranslationWrapper {
    Camera *camera;
    u8 duration;
    u8 step;
    u8 mode;
    u8 active;
    struct CameraTranslationPathTemplate init;
    struct CameraTranslationPathTemplate target;
    SysTask *task; // returned from SysTask_CreateOnMainQueue
} GFCameraTranslationWrapper;

GFCameraTranslationWrapper *CreateCameraTranslationWrapper(enum HeapID heapID, Camera *camera);
void DeleteCameraTranslationWrapper(GFCameraTranslationWrapper *wrapper);
void SetCameraTranslationPath(GFCameraTranslationWrapper *wrapper, struct CameraTranslationPathTemplate *template, int duration);
u8 IsCameraTranslationFinished(GFCameraTranslationWrapper *wrapper);

#endif // POKEPLATINUM_CAMERA_TRANSLATION_H
