LOCAL_PATH:= $(call my-dir)

#
# libmediaplayerservice
#

include $(CLEAR_VARS)

ifneq ($(filter rk%, $(TARGET_BOARD_PLATFORM)), )
LOCAL_CFLAGS := -DAVS50
BUILD_FF_PLAYER := true
else
BUILD_FF_PLAYER := false
endif

LOCAL_SRC_FILES :=               \
    ActivityManager.cpp         \
    Crypto.cpp                  \
    Drm.cpp                     \
    HDCP.cpp                    \
    MediaPlayerFactory.cpp      \
    MediaPlayerService.cpp      \
    MediaRecorderClient.cpp     \
    MetadataRetrieverClient.cpp \
    MidiFile.cpp                \
    MidiMetadataRetriever.cpp   \
    RemoteDisplay.cpp           \
    SharedLibrary.cpp           \
    StagefrightPlayer.cpp       \
    StagefrightRecorder.cpp     \
    TestPlayerStub.cpp          \
    VideoFrameScheduler.cpp     
    
LOCAL_SHARED_LIBRARIES :=       \
    libbinder                   \
    libcamera_client            \
    libcrypto                   \
    libcutils                   \
    libdrmframework             \
    liblog                      \
    libdl                       \
    libgui                      \
    libmedia                    \
    libsonivox                  \
    libstagefright              \
    libstagefright_foundation   \
    libstagefright_httplive     \
    libstagefright_omx          \
    libstagefright_wfd          \
    libutils                    \
    libvorbisidec                            

LOCAL_STATIC_LIBRARIES :=       \
    libstagefright_nuplayer     \
    libstagefright_rtsp         

LOCAL_C_INCLUDES :=                                                 \
    external/mac  \
    $(TOP)/frameworks/av/media/libstagefright/include               \
    $(TOP)/frameworks/av/media/libstagefright/rtsp                  \
    $(TOP)/frameworks/av/media/libstagefright/wifi-display          \
    $(TOP)/frameworks/av/media/libstagefright/webm                  \
    $(TOP)/frameworks/native/include/media/openmax                  \
    $(TOP)/external/tremolo/Tremolo                                 
    
ifeq ($(strip $(BUILD_FF_PLAYER)),true)
LOCAL_SRC_FILES += \
    FFPlayer.cpp\
    ApePlayer.cpp

LOCAL_CFLAGS +=	\
    -DUSE_FFPLAYER\
    -DUSE_APEPLAYER

LOCAL_SHARED_LIBRARIES += \
    librkffplayer\
    libapedec

LOCAL_C_INCLUDES += \
	$(TOP)/external/ffmpeg                                          \
    $(TOP)/frameworks/av/media/libstagefright/libvpu/common	        \
    $(TOP)/frameworks/av/media/libstagefright/libvpu/common/include \
    $(TOP)/hardware/rockchip/librkvpu                               \
    $(TOP)/frameworks/av/media/rk_ffplayer
endif 
    
    
    
LOCAL_MODULE:= libmediaplayerservice

LOCAL_32_BIT_ONLY := true

include $(BUILD_SHARED_LIBRARY)

include $(call all-makefiles-under,$(LOCAL_PATH))
